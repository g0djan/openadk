# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

_UNLIMIT=	ulimit -dS $(shell ulimit -dH >/dev/null 2>/dev/null ) >/dev/null 2>/dev/null;

all: .prereq_done
	@${_UNLIMIT} ${GMAKE_INV} all

v: .prereq_done
	@(echo; echo "Build started on $$(LC_ALL=C LANGUAGE=C date)"; \
	    set -x; ${_UNLIMIT} ${GMAKE_FMK} VERBOSE=1 all) 2>&1 | tee -a make.log

help:
	@echo 'Common targets:'
	@echo '  switch TARGET=targetname  - Backup current config and copy old saved target config'
	@echo '  download     - fetches all needed distfiles'
	@echo 'Cleaning targets:'
	@echo '  clean        - Remove bin and build_dir directories'
	@echo '  cleantarget  - Same as "clean", but also remove toolchain for target'
	@echo '  cleandir     - Same as "clean", but also remove all built toolchains'
	@echo '  cleankernel  - Remove kernel dir, useful if you changed any kernel patches'
	@echo '  distclean    - Same as "cleandir", but also remove downloaded'
	@echo '                 distfiles and .config'
	@echo ''
	@echo 'Configuration targets:'
	@echo '  config       - Update current config utilising a line-oriented program'
	@echo '  menuconfig   - Update current config utilising a menu based program'
	@echo '                 (default when .config does not exist)'
	@echo '  oldconfig    - Update current config utilising a provided .configs base'
	@echo '  wconfig      - Same as "oldconfig", but also writes out hidden symbols'
	@echo '  allmodconfig - New config selecting all packages as modules when possible'
	@echo '  allconfig    - New config selecting all packages when possible'
	@echo '  allnoconfig  - New config where all options are answered with no'
	@echo '  kernelconfig - Modify the target kernel configuration'
	@echo ''
	@echo 'Help targets:'
	@echo '  help         - Print this help text'
	@echo '  pkg-help     - Print help about selectively compiling single packages'
	@echo '  dev-help     - Print help for developers / package maintainers'
	@echo ''
	@echo 'Other generic targets:'
	@echo '  all          - Build everything as specified in .config'
	@echo '                 (default if .config exists)'
	@echo '  v            - Same as "all" but with logging to make.log enabled'

pkg-help:
	@echo 'Package specific targets (use with "package=<pkg-name>" parameter):'
	@echo '  fetch        - Download the necessary distfile'
	@echo '  extract      - Same as "fetch", but also extract the distfile'
	@echo '  patch        - Same as "extract", but also patch the source'
	@echo '  build        - Same as "patch", but also build the binaries'
	@echo '  fake         - Same as "build", but also install the binaries'
	@echo '  package      - Same as "fake", but also create the package'
	@echo '  clean        - Deinstall and remove the build area'
	@echo '  distclean    - Same as "clean", but also remove the distfiles'
	@echo ''
	@echo 'Short package rebuilding guide:'
	@echo '  run "make package=<pkgname> clean" to remove all generated binaries'
	@echo '  run "make package=<pkgname> package" to build everything and create the package(s)'
	@echo ''
	@echo 'This does not automatically resolve package dependencies!'

dev-help:
	@echo 'Regenerate menu information via "make menu"'
	@echo 'Regenerate dependency information via "make dep"'
	@echo
	@echo 'Fast way of updating package patches:'
	@echo '  run "make package=<pkgname> clean" to start with a good base'
	@echo '  run "make package=<pkgname> patch" to fetch, unpack and patch the source'
	@echo '  edit the package sources at build_dir/w-<pkgname>-*/<pkgname>-<version>'
	@echo '  run "make package=<pkgname> update-patches" to regenerate patch files'
	@echo ''
	@echo 'All changed patches will be opened with your $$EDITOR,'
	@echo 'so you can add a description and verify the modifications.'
	@echo ''
	@echo 'Adding a new package:'
	@echo 'make PKG=foo VER=1.0 newpackage'

clean: .prereq_done
	-@rm -f nohup.out
	@${GMAKE_INV} clean

config: .prereq_done
	@${GMAKE_INV} _config W=

oldconfig: .prereq_done
	@${GMAKE_INV} _config W=-o

wconfig: .prereq_done
	@${GMAKE_INV} _config W=-A

download: .prereq_done
	@${GMAKE_INV} toolchain/download
	@${GMAKE_INV} package/download

cleankernel kernelclean: .prereq_done
	-@${GMAKE_INV} cleankernel

cleandir dirclean: .prereq_done
	-@${GMAKE_INV} cleandir
	@-rm -f make.log .prereq_done

cleantarget targetclean: .prereq_done
	-@${GMAKE_INV} cleantarget
	@-rm -f make.log

distclean cleandist:
	-@${GMAKE_INV} distclean
	@-rm -f make.log .prereq_done

image: .prereq_done
	@${GMAKE_INV} image

switch: .prereq_done
	@${GMAKE_INV} switch

kernelconfig: .prereq_done
	@${GMAKE_INV} kernelconfig

newpackage: .prereq_done
	@${GMAKE_INV} newpackage

image_clean imageclean cleanimage: .prereq_done
	@${GMAKE_INV} image_clean

menuconfig: .prereq_done
	@${GMAKE_INV} menuconfig

defconfig: .prereq_done
	@${GMAKE_INV} defconfig

allnoconfig: .prereq_done
	@${GMAKE_INV} _config W=-n

allconfig: .prereq_done
	@${GMAKE_INV} _mconfig W=-y RCONFIG=Config.in

allmodconfig: .prereq_done
	@${GMAKE_INV} _mconfig W=-o RCONFIG=Config.in

package_index: .prereq_done
	@${GMAKE_INV} package_index

bulk: .prereq_done
	@${GMAKE_INV} bulk

bulkall: .prereq_done
	@${GMAKE_INV} bulkall

bulkallmod: .prereq_done
	@${GMAKE_INV} bulkallmod

menu: .prereq_done
	@${GMAKE_INV} menu

dep: .prereq_done
	@${GMAKE_INV} dep

world: .prereq_done
	@${GMAKE_INV} world

prereq:
	@rm -f .prereq_done
	@${GMAKE} .prereq_done

prereq-noerror:
	@rm -f .prereq_done
	@${GMAKE} .prereq_done NO_ERROR=1

NO_ERROR=0
.prereq_done:
	@-rm -rf .prereq_done
	@if ! bash --version 2>&1 | fgrep 'GNU bash' >/dev/null 2>&1; then \
		echo "GNU bash needs to be installed."; \
		exit 1; \
	fi
	@if ! mksh -c 'echo $$KSH_VERSION' 2>&1 | fgrep 'MIRBSD' >/dev/null 2>&1; then \
		echo "MirBSD ksh (mksh) needs to be installed."; \
		exit 1; \
	else \
		if [ $$(mksh -c 'echo $$KSH_VERSION' |cut -d ' ' -f 3|sed "s#R##") -le 34 ]; then \
			echo "MirBSD ksh is too old. R35 or higher needed."; \
			exit 1; \
		fi \
	fi
	@if test x"$$(umask 2>/dev/null | sed 's/00*22/OK/')" != x"OK"; then \
		echo >&2 Error: you must build with umask 022, sorry.; \
		exit 1; \
	fi
	@echo "TOPDIR:=$$(readlink -nf . 2>/dev/null || pwd -P)" >prereq.mk
	@echo "BASH:=$$(which bash)" >>prereq.mk
	@if [ -z "$$(which gmake 2>/dev/null )" ]; then \
		echo "GMAKE:=$$(which make)" >>prereq.mk ;\
	else \
		echo "GMAKE:=$$(which gmake)" >>prereq.mk ;\
	fi
	@echo "GNU_HOST_NAME:=$$(${CC} -dumpmachine)" >>prereq.mk
	@echo "HOST_ARCH:=$$(${CC} -dumpmachine | sed -e s'/-.*//' \
	    -e 's/sparc.*/sparc/' \
	    -e 's/arm.*/arm/g' \
	    -e 's/m68k.*/m68k/' \
	    -e 's/ppc/powerpc/g' \
	    -e 's/v850.*/v850/g' \
	    -e 's/sh[234]/sh/' \
	    -e 's/mips-.*/mips/' \
	    -e 's/mipsel-.*/mipsel/' \
	    -e 's/cris.*/cris/' \
	    -e 's/i[3-9]86/i386/' \
	    )" >>prereq.mk
	@echo 'HOSTCC:=${CC}' >>prereq.mk
	@echo 'HOSTCFLAGS:=-O2' >>prereq.mk
	@echo 'LANGUAGE:=C' >>prereq.mk
	@echo 'LC_ALL:=C' >>prereq.mk
	@echo 'MAKE:=$${GMAKE}' >>prereq.mk
	@echo "OStype:=$$(env uname)" >>prereq.mk
	@echo "_PATH:=$$PATH" >>prereq.mk
	@echo "PATH:=\$${TOPDIR}/scripts:$$PATH" >>prereq.mk
	@echo "SHELL:=$$(which bash)" >>prereq.mk
	@env NO_ERROR=${NO_ERROR} BASH="$$(which bash)" \
		CC='${CC}' CPPFLAGS='${CPPFLAGS}' \
	    	bash scripts/scan-tools.sh
	@echo '===> Prerequisites checked successfully.'
	@touch $@

.PHONY: prereq prereq-noerror
