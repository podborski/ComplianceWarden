%define BE(a) ( ((((a)>>24)&0xFF) << 0) + ((((a)>>16)&0xFF) << 8) + ((((a)>>8)&0xFF) << 16)  + ((((a)>>0)&0xFF) << 24) )

stsd_start:
dd BE(stsd_end - stsd_start)
db "stsd"
dd BE(0)
dd BE(0)
dd BE(0); extra bytes: 'stsd' parsing will underflow
stsd_end:
