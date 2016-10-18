# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

choice
prompt "GNU debugger"

config ADK_TOOLCHAIN_WITHOUT_GDB
	bool "disabled"
	help
	  Disable GDB for the host.

config ADK_TOOLCHAIN_WITH_GDB
	bool "enabled"
	help
	  Enable GDB for the host. Version selection will be used
	  for gdb/gdbserver for the target.

endchoice

choice
prompt "GNU debugger version"
depends on ADK_TOOLCHAIN_WITH_GDB
default ADK_TOOLCHAIN_GDB_H8300_GIT if ADK_TARGET_ARCH_H8300
default ADK_TOOLCHAIN_GDB_NDS32 if ADK_TARGET_ARCH_NDS32
default ADK_TOOLCHAIN_GDB_7_12

config ADK_TOOLCHAIN_GDB_GIT
	bool "git"
	depends on !ADK_TARGET_ARCH_AVR32
	depends on !ADK_TARGET_ARCH_H8300
	depends on !ADK_TARGET_ARCH_NDS32

config ADK_TOOLCHAIN_GDB_H8300_GIT
	bool "h8300-git"
	depends on ADK_TARGET_ARCH_H8300

config ADK_TOOLCHAIN_GDB_7_12
	bool "7.12"
	depends on !ADK_TARGET_ARCH_AVR32
	depends on !ADK_TARGET_ARCH_H8300
	depends on !ADK_TARGET_ARCH_NDS32

config ADK_TOOLCHAIN_GDB_7_11_1
	bool "7.11.1"
	depends on !ADK_TARGET_ARCH_AVR32
	depends on !ADK_TARGET_ARCH_H8300
	depends on !ADK_TARGET_ARCH_NDS32

config ADK_TOOLCHAIN_GDB_7_10_1
	bool "7.10.1"
	depends on !ADK_TARGET_ARCH_AVR32
	depends on !ADK_TARGET_ARCH_H8300
	depends on !ADK_TARGET_ARCH_NDS32

config ADK_TOOLCHAIN_GDB_6_7_1
	bool "6.7.1"
	depends on ADK_TARGET_ARCH_AVR32

endchoice
