#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "box.h"
#include "common_boxes.h"
#include "parser.h"
#include "spec.h"

using namespace std;

vector<uint8_t> loadFile(const char* path)
{
  FILE* fp = fopen(path, "rb");
  vector<uint8_t> buf(100 * 1024 * 1024);
  auto const size = fread(buf.data(), 1, buf.size(), fp);
  fclose(fp);
  buf.resize(size);
  buf.shrink_to_fit();
  return buf;
}

void dump(Box const& box, int depth = 0)
{
  for(int i = 0; i < depth; ++i)
    printf("  ");

  printf("%c%c%c%c",
         (box.fourcc >> 24) & 0xff,
         (box.fourcc >> 16) & 0xff,
         (box.fourcc >> 8) & 0xff,
         (box.fourcc >> 0) & 0xff);
  printf("\n");

  for(auto& sym : box.syms)
  {
    if(!strcmp(sym.name, ""))
      continue;

    for(int i = 0; i < depth; ++i)
      printf("  ");

    printf("%s: %lld\n", sym.name, (long long)sym.value);
  }

  for(auto& child : box.children)
    dump(child, depth + 1);
}

void checkCompliance(Box const& file, SpecDesc const* spec)
{
  struct Report : IReport
  {
    void error(const char* fmt, ...) override
    {
      fprintf(stdout, "[Rule #%d] %s\n", ruleIdx, fmt);
    }

    int ruleIdx = 0;
  };

  Report out;

  for(auto& rule : spec->rules)
  {
    rule.check(file, &out);
    out.ruleIdx++;
  }
}

std::vector<SpecDesc const*> g_allSpecs;

int registerSpec(SpecDesc const* spec)
{
  g_allSpecs.push_back(spec);
  return 0;
}

SpecDesc const* findSpec(const char* name)
{
  for(auto& spec : g_allSpecs)
    if(strcmp(spec->name, name) == 0)
      return spec;

  fprintf(stderr, "Spec '%s' not found\n", name);
  exit(1);
}

struct BoxReader : IReader
{
  bool empty() override
  {
    return br.empty();
  }

  int64_t sym(const char* name, int bits) override
  {
    auto val = br.u(bits);
    myBox.add(name, val);
    return val;
  }

  void box() override
  {
    BoxReader subReader;
    const uint32_t size = br.u(32);
    subReader.myBox.fourcc = br.u(32);
    subReader.br = br.sub(int(size - 8));
    auto parseFunc = getParseFunction(subReader.myBox.fourcc);
    parseFunc(&subReader);

    myBox.children.push_back(std::move(subReader.myBox));
  }

  BitReader br;
  Box myBox;
};

int main(int argc, const char* argv[])
{
  if(argc != 3)
  {
    fprintf(stderr, "Usage: %s <spec> <input.mp4>\n", argv[0]);
    return 1;
  }

  auto spec = findSpec(argv[1]);

  auto buf = loadFile(argv[2]);
  BoxReader topReader;
  topReader.br = { buf.data(), (int)buf.size() };
  topReader.myBox.fourcc = FOURCC("root");
  auto func = getParseFunction(topReader.myBox.fourcc);
  func(&topReader);
  dump(topReader.myBox);

  checkCompliance(topReader.myBox, spec);

  return 0;
}

