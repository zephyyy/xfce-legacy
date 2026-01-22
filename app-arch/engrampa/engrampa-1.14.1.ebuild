# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg-utils gnome2-utils

DESCRIPTION="Engrampa archive manager for MATE"
HOMEPAGE="https://mate-desktop.org"
SRC_URI="https://pub.mate-desktop.org/releases/${PV%.*}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm x86 ppc64"

IUSE="+magic"

COMMON_DEPEND="
	dev-libs/glib
	dev-libs/json-glib
	x11-libs/gdk-pixbuf:2
	x11-libs/pango:0
	virtual/libintl:0
	x11-libs/gtk+:2
	magic? ( sys-apps/file )
"

RDEPEND="${COMMON_DEPEND}"

BDEPEND="
	app-text/yelp-tools
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}/p7zip-15.14-compat.patch"
	"${FILESDIR}/Remove-unused-g_ptr_array_copy.patch"
	"${FILESDIR}/Add-zcompress-support.patch"
	"${FILESDIR}/Zstandard-read-.tar.zst-files.patch"
	"${FILESDIR}/gcc10.patch"
)

src_prepare() {
	default
	sed -i data/Makefile.* -e 's,/appdata,/metainfo,'
}

src_configure() {
	econf \
		--disable-run-in-place \
		--disable-deprecations \
		--with-gtk=2.0 \
		--disable-caja-actions \
		--disable-packagekit \
		$(use_enable magic)
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	gnome2_schemas_update
}
