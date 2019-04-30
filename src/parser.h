#pragma once

#include "box.h"
#include <cassert>

struct BitReader
{
  uint8_t* src;
  int size = 0;

  int64_t u(int n)
  {
    uint64_t r = 0;

    for(int i = 0; i < n; ++i)
      r = (r << 1) | bit();

    return r;
  }

  BitReader sub(int byteCount)
  {
    assert(m_pos % 8 == 0);
    auto sub = BitReader { src + m_pos / 8, byteCount };
    m_pos += byteCount * 8;
    return sub;
  }

  int bit()
  {
    const int byteOffset = m_pos / 8;
    const int bitOffset = m_pos % 8;

    assert(byteOffset < size);

    m_pos++;
    return (src[byteOffset] >> (7 - bitOffset)) & 1;
  }

  bool empty() const
  {
    return m_pos / 8 >= size;
  }

  int m_pos = 0;
};

///////////////////////////////////////////////////////////////////////////////

struct IReader
{
  virtual bool empty() = 0;
  virtual int64_t sym(const char* name, int bits) = 0;
  virtual void box() = 0;
};

using ParseBoxFunc = void(IReader * br);

