# arm default is little endian, this target uses EABI
ARCH:=			arm
CPU_ARCH:=		arm
KERNEL_VERSION:=	2.6.35.7
KERNEL_RELEASE:=	1
KERNEL_MD5SUM:=		f741879bcd3a5366a1bbe0ad5cdb7935
TARGET_OPTIMIZATION:=	-Os -pipe
TARGET_CFLAGS_ARCH:=    -march=armv5te -mtune=arm926ej-s
