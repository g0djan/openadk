# arm default is little endian, this target uses EABI
ARCH:=			arm
CPU_ARCH:=		arm
KERNEL_VERSION:=	2.6.35.4
KERNEL_RELEASE:=	1
KERNEL_MD5SUM:=		0bb2cd59c13d7412f813c8fbc0769eec
TARGET_OPTIMIZATION:=	-Os -pipe
TARGET_CFLAGS_ARCH:=    -march=armv5te -mtune=arm926ej-s
