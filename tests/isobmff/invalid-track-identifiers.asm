%define BE(a) ( ((((a)>>24)&0xFF) << 0) + ((((a)>>16)&0xFF) << 8) + ((((a)>>8)&0xFF) << 16)  + ((((a)>>0)&0xFF) << 24))
%define fourcc(a) db a

ftyp_start:
dd BE(ftyp_end - ftyp_start)
db "ftyp"
db "isom"
dd BE(0x200)
db "mif1", "miaf"
ftyp_end:

moov_start:
dd BE(moov_end - moov_start)
fourcc("moov")
mvhd_start:
    dd BE(mvhd_end - mvhd_start)
    dd "mvhd"
mvhd_end:

trak_start:
dd BE(trak_end - trak_start)
fourcc("trak")

tkhd_start:
    dd BE(tkhd_end - tkhd_start)
    dd "tkhd"
    db 0x00 ; version(8) 
    db 0x00, 0x00, 0x01 ; flags(24) 
    db 0xD7, 0xAE, 0x43, 0xC0 ; creation_time(32) 
    db 0xD8, 0x7E, 0xD7, 0x51 ; modification_time(32) 
    db 0x00, 0x00, 0x00, 0x02 ; track_ID(32) 
    db 0x00, 0x00, 0x00, 0x00 ; reserved(32) 
    db 0x00, 0x00, 0x09, 0x49 ; duration(32) 
    db 0x00, 0x00, 0x00, 0x00 ; reserved(32) 
    db 0x00, 0x00, 0x00, 0x00 ; reserved(32) 
    db 0x00, 0x00 ; layer(16) 
    db 0x00, 0x00 ; alternate_group(16) 
    db 0x00, 0x00 ; volume(16) 
    db 0x00, 0x00 ; reserved(16) 
    db 0x00, 0x01, 0x00, 0x00 ; matrix(32) 
    db 0x00, 0x00, 0x00, 0x00 ; matrix(32) 
    db 0x00, 0x00, 0x00, 0x00 ; matrix(32) 
    db 0x00, 0x00, 0x00, 0x00 ; matrix(32) 
    db 0x00, 0x01, 0x00, 0x00 ; matrix(32) 
    db 0x00, 0x00, 0x00, 0x00 ; matrix(32) 
    db 0x00, 0x00, 0x00, 0x00 ; matrix(32) 
    db 0x00, 0x00, 0x00, 0x00 ; matrix(32) 
    db 0x40, 0x00, 0x00, 0x00 ; matrix(32) 
    db 0x01, 0xE0, 0x00, 0x00 ; width(32) 
    db 0x01, 0x0E, 0x00, 0x00 ; height(32) 
tkhd_end:

mdia_start:
dd BE(mdia_end - mdia_start)
fourcc("mdia")

hdlr_start:
dd BE(hdlr_end - hdlr_start)
db "hdlr"
db 0x00 ; version(8) 
db 0x00, 0x00, 0x00 ; flags(24) 
db 0x00, 0x00, 0x00, 0x00 ; pre_defined(32) 
db 0x70, 0x69, 0x63, 0x74 ; handler_type(32) ('pict') 
db 0x00, 0x00, 0x00, 0x00 ; reserved1(32) 
db 0x00, 0x00, 0x00, 0x00 ; reserved2(32) 
db 0x00, 0x00, 0x00, 0x00 ; reserved3(32) 
db 0x00 ; name(8) 
hdlr_end:

mdhd_start:
    dd BE(mdhd_end - mdhd_start)
    dd "mdhd"
mdhd_end:

minf_start:
dd BE(minf_end - minf_start)
fourcc("minf")
vmhd_start:
    dd BE(vmhd_end - vmhd_start)
    dd "vmhd"
    db 0x00 ; (8) 
    db 0x00 ; (8) 
    db 0x00 ; (8) 
    db 0x01 ; (8) 
    db 0x00 ; (8) 
    db 0x00 ; (8) 
    db 0x00 ; (8) 
    db 0x00 ; (8) 
    db 0x00 ; (8) 
    db 0x00 ; (8) 
    db 0x00 ; (8) 
    db 0x00 ; (8) 
vmhd_end:
dinf_start:
    dd BE(dinf_end - dinf_start)
    dd "dinf"
    dref_start:
        dd BE(dref_end - dref_start)
        dd "dref"
        db 0x00 ; version(8) 
        db 0x00, 0x00, 0x00 ; flags(24) 
        db 0x00, 0x00, 0x00, 0x01 ; entry_count(32) 
        url_start:
            dd BE(url_end - url_start)
            dd "url "
            db 0x00 ; version(8) 
            db 0x00, 0x00, 0x01 ; flags(24) 
        url_end:
    dref_end:
dinf_end:
stbl_start:
dd BE(stbl_end - stbl_start)
fourcc("stbl")
stsd_start:
dd BE(stsd_end - stsd_start)
fourcc("stsd")
dd BE(0)
dd BE(0) ; entry_count
stsd_end:

stts_start:
    dd BE(stts_end - stts_start)
    dd "stts"
    db 0x00 ; version(8) 
    db 0x00, 0x00, 0x00 ; flags(24) 
    db 0x00, 0x00, 0x00, 0x01 ; entry_count(32) 
    db 0x00, 0x00, 0x00, 0x01 ; sample_count(32) 
    db 0x00, 0x00, 0x00, 0x01 ; sample_delta(32) 
stts_end:
stsc_start:
    dd BE(stsc_end - stsc_start)
    dd "stsc"
    db 0x00, 0x00, 0x00, 0x00
    db 0x00, 0x00, 0x00, 0x00
    db 0x00, 0x00, 0x00, 0x00
stsc_end:
stsz_start:
    dd BE(stsz_end - stsz_start)
    dd "stsz"
    db 0x00, 0x00, 0x00, 0x01
    db 0x00, 0x00, 0x00, 0x01
stsz_end:
stco_start:
    dd BE(stco_end - stco_start)
    dd "stco"
    db 0x00 ; version(8) 
    db 0x00, 0x00, 0x00 ; flags(24) 
    db 0x00, 0x00, 0x00, 0x01 ; entry_count(32) 
    db 0x00, 0x00, 0x55, 0x7D ; chunk_offset(32) 
stco_end:

stbl_end:
minf_end:
mdia_end:
trak_end:

trak2_start:
dd BE(trak2_end - trak2_start)
fourcc("trak")

tkhd2_start:
    dd BE(tkhd2_end - tkhd2_start)
    dd "tkhd"
    db 0x00 ; version(8) 
    db 0x00, 0x00, 0x01 ; flags(24) 
    db 0xD7, 0xAE, 0x43, 0xC0 ; creation_time(32) 
    db 0xD8, 0x7E, 0xD7, 0x51 ; modification_time(32) 
    db 0x00, 0x00, 0x00, 0x02 ; track_ID(32) 
    db 0x00, 0x00, 0x00, 0x00 ; reserved(32) 
    db 0x00, 0x00, 0x09, 0x49 ; duration(32) 
    db 0x00, 0x00, 0x00, 0x00 ; reserved(32) 
    db 0x00, 0x00, 0x00, 0x00 ; reserved(32) 
    db 0x00, 0x00 ; layer(16) 
    db 0x00, 0x00 ; alternate_group(16) 
    db 0x00, 0x00 ; volume(16) 
    db 0x00, 0x00 ; reserved(16) 
    db 0x00, 0x01, 0x00, 0x00 ; matrix(32) 
    db 0x00, 0x00, 0x00, 0x00 ; matrix(32) 
    db 0x00, 0x00, 0x00, 0x00 ; matrix(32) 
    db 0x00, 0x00, 0x00, 0x00 ; matrix(32) 
    db 0x00, 0x01, 0x00, 0x00 ; matrix(32) 
    db 0x00, 0x00, 0x00, 0x00 ; matrix(32) 
    db 0x00, 0x00, 0x00, 0x00 ; matrix(32) 
    db 0x00, 0x00, 0x00, 0x00 ; matrix(32) 
    db 0x40, 0x00, 0x00, 0x00 ; matrix(32) 
    db 0x01, 0xE0, 0x00, 0x00 ; width(32) 
    db 0x01, 0x0E, 0x00, 0x00 ; height(32) 
tkhd2_end:

mdia2_start:
dd BE(mdia2_end - mdia2_start)
fourcc("mdia")

hdlr2_start:
dd BE(hdlr2_end - hdlr2_start)
db "hdlr"
db 0x00 ; version(8) 
db 0x00, 0x00, 0x00 ; flags(24) 
db 0x00, 0x00, 0x00, 0x00 ; pre_defined(32) 
db 0x70, 0x69, 0x63, 0x74 ; handler_type(32) ('pict') 
db 0x00, 0x00, 0x00, 0x00 ; reserved1(32) 
db 0x00, 0x00, 0x00, 0x00 ; reserved2(32) 
db 0x00, 0x00, 0x00, 0x00 ; reserved3(32) 
db 0x00 ; name(8) 
hdlr2_end:

mdhd2_start:
    dd BE(mdhd2_end - mdhd2_start)
    dd "mdhd"
mdhd2_end:

minf2_start:
dd BE(minf2_end - minf2_start)
fourcc("minf")
vmhd2_start:
    dd BE(vmhd2_end - vmhd2_start)
    dd "vmhd"
    db 0x00 ; (8) 
    db 0x00 ; (8) 
    db 0x00 ; (8) 
    db 0x01 ; (8) 
    db 0x00 ; (8) 
    db 0x00 ; (8) 
    db 0x00 ; (8) 
    db 0x00 ; (8) 
    db 0x00 ; (8) 
    db 0x00 ; (8) 
    db 0x00 ; (8) 
    db 0x00 ; (8) 
vmhd2_end:
dinf2_start:
    dd BE(dinf2_end - dinf2_start)
    dd "dinf"
    dref2_start:
        dd BE(dref2_end - dref2_start)
        dd "dref"
        db 0x00 ; version(8) 
        db 0x00, 0x00, 0x00 ; flags(24) 
        db 0x00, 0x00, 0x00, 0x01 ; entry_count(32) 
        url2_start:
            dd BE(url2_end - url2_start)
            dd "url "
            db 0x00 ; version(8) 
            db 0x00, 0x00, 0x01 ; flags(24) 
        url2_end:
    dref2_end:
dinf2_end:
stbl2_start:
dd BE(stbl2_end - stbl2_start)
fourcc("stbl")
stsd2_start:
dd BE(stsd2_end - stsd2_start)
fourcc("stsd")
dd BE(0)
dd BE(0) ; entry_count
stsd2_end:

stts2_start:
    dd BE(stts2_end - stts2_start)
    dd "stts"
    db 0x00 ; version(8) 
    db 0x00, 0x00, 0x00 ; flags(24) 
    db 0x00, 0x00, 0x00, 0x01 ; entry_count(32) 
    db 0x00, 0x00, 0x00, 0x01 ; sample_count(32) 
    db 0x00, 0x00, 0x00, 0x01 ; sample_delta(32) 
stts2_end:
stsc2_start:
    dd BE(stsc2_end - stsc2_start)
    dd "stsc"
    db 0x00, 0x00, 0x00, 0x00
    db 0x00, 0x00, 0x00, 0x00
    db 0x00, 0x00, 0x00, 0x00
stsc2_end:
stsz2_start:
    dd BE(stsz2_end - stsz2_start)
    dd "stsz"
    db 0x00, 0x00, 0x00, 0x01
    db 0x00, 0x00, 0x00, 0x01
stsz2_end:
stco2_start:
    dd BE(stco2_end - stco2_start)
    dd "stco"
    db 0x00 ; version(8) 
    db 0x00, 0x00, 0x00 ; flags(24) 
    db 0x00, 0x00, 0x00, 0x01 ; entry_count(32) 
    db 0x00, 0x00, 0x55, 0x7D ; chunk_offset(32) 
stco2_end:

stbl2_end:
minf2_end:
mdia2_end:
trak2_end:

moov_end:

; vim: syntax=nasm
