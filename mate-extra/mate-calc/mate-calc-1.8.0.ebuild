# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg-utils

DESCRIPTION="A calculator application for MATE"
HOMEPAGE="https://mate-desktop.org"
SRC_URI="https://pub.mate-desktop.org/releases/${PV%.*}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86 ppc64"

RDEPEND="
	>=dev-libs/glib-2.30:2
	>=x11-libs/gtk+-2.18:2
	dev-libs/atk:0
	dev-libs/libxml2:2
"
DEPEND="${RDEPEND}"
BDEPEND="
	app-text/yelp-tools:0
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig
"

src_configure() {
	econf --with-gtk=2.0
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
