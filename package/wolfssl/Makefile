# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include $(ADK_TOPDIR)/rules.mk

PKG_NAME:=		wolfssl
PKG_VERSION:=		5.0.0
PKG_RELEASE:=		1
PKG_HASH:=		908390282cc613a3943533f3d922b3c18dee3289f498b6f944cb86a19a5eeb56
PKG_DESCR:=		portable embedded ssl library
PKG_SECTION:=		libs/crypto
PKG_URL:=		http://www.wolfssl.com
PKG_SITES:=		https://github.com/wolfSSL/wolfssl/archive/refs/tags/
PKG_OPTS:=		dev

DISTFILES:=		v$(PKG_VERSION)-stable.tar.gz
WRKDIST=		${WRKDIR}/${PKG_NAME}-${PKG_VERSION}-stable

include $(ADK_TOPDIR)/mk/package.mk

$(eval $(call PKG_template,WOLFSSL,wolfssl,$(PKG_VERSION)-$(PKG_RELEASE),$(PKG_DEPENDS),$(PKG_DESCR),$(PKG_SECTION),$(PKG_OPTS)))

AUTOTOOL_STYLE:=	autogen
CONFIGURE_ARGS+=	--disable-examples
CONFIGURE_ENV+=		C_EXTRA_FLAGS='$(TARGET_CFLAGS)'

wolfssl-install:
	$(INSTALL_DIR) $(IDIR_WOLFSSL)/usr/lib
	$(CP) $(WRKINST)/usr/lib/libwolfssl*.so* \
		$(IDIR_WOLFSSL)/usr/lib

include $(ADK_TOPDIR)/mk/pkg-bottom.mk
