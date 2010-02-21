# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

define rootfs_template
ifeq ($(ADK_TARGET_ROOTFS_$(2)),y)
FS:=$(1)
FS_CMDLINE:=$(3)
endif
endef

ifeq ($(ADK_LINUX_MIPS_RB532),y)
ROOTFS:=	root=/dev/sda2
endif

ifeq ($(ADK_LINUX_ARM_FOXBOARD),y)
ROOTFS:=	root=/dev/mmcblk0p2
endif

$(eval $(call rootfs_template,ext2-block,EXT2_BLOCK,$(ROOTFS)))
$(eval $(call rootfs_template,archive,ARCHIVE))
$(eval $(call rootfs_template,initramfs,INITRAMFS))
$(eval $(call rootfs_template,initramfs-piggyback,INITRAMFS_PIGGYBACK))
$(eval $(call rootfs_template,squashfs,SQUASHFS))
$(eval $(call rootfs_template,yaffs,YAFFS,root=/dev/mtdblock1))
$(eval $(call rootfs_template,nfsroot,NFSROOT,root=/dev/nfs ip=dhcp init=/init))
$(eval $(call rootfs_template,encrypted,ENCRYPTED))

export FS
