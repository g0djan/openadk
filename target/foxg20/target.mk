# arm default is little endian, this target uses EABI
ARCH:=			arm
CPU_ARCH:=		arm
KERNEL_VERSION:=	2.6.33
KERNEL_RELEASE:=	1
KERNEL_MD5SUM:=		c3883760b18d50e8d78819c54d579b00
TARGET_OPTIMIZATION:=	-Os -pipe
TARGET_CFLAGS_ARCH:=    -march=armv5te -mtune=arm926ej-s
