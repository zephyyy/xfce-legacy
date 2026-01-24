# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A MATE specific DBUS service that is used to bring up authentication dialogs"
HOMEPAGE="https://mate-desktop.org"
SRC_URI="https://pub.mate-desktop.org/releases/${PV%.*}/${P}.tar.xz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 arm x86 ppc64"

IUSE="accountsservice gtk3 +introspection"

COMMON_DEPEND="
	>=dev-libs/glib-2.36:2
	>=sys-auth/polkit-0.102:0[introspection?]
	x11-libs/gdk-pixbuf:2[introspection?]
	virtual/libintl:0
	>=x11-libs/gtk+-2.24:2[introspection?]
	introspection? ( >=dev-libs/gobject-introspection-0.6.2:= )
"
RDEPEND="
	${COMMON_DEPEND}
	accountsservice? ( sys-apps/accountsservice:0[introspection?] )
"
DEPEND="${COMMON_DEPEND}"
BDEPEND="
	dev-util/gtk-doc
	dev-build/gtk-doc-am
	>=dev-util/intltool-0.35:*
	sys-devel/gettext:*
	>=dev-build/libtool-2.2.6
	virtual/pkgconfig:*
	!<gnome-extra/polkit-gnome-0.102:0
"

src_prepare() {
	default
	sed -i src/*desktop* -e '/^OnlyShowIn/d'
}

src_configure() {
	econf \
		--disable-static \
		--with-gtk=$(usex gtk3 3.0 2.0) \
		--disable-debug \
		--disable-examples \
		--disable-appindicator \
		$(use_enable accountsservice) \
		$(use_enable introspection)
}
