# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 xdg-utils

DESCRIPTION="Font viewer utility for MATE Desktop"
HOMEPAGE="https://mate-desktop.org"
EGIT_REPO_URI="https://github.com/zephyyy/${PN}.git"
EGIT_COMMIT="v${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86 ppc64"
IUSE=""

COMMON_DEPEND="
	media-libs/fontconfig
	media-libs/freetype:2
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2
"
RDEPEND="
	${COMMON_DEPEND}
	!mate-base/mate-control-center
"
BDEPEND="
	virtual/pkgconfig
"

src_prepare() {
	default
	NOCONFIGURE=1 ./autogen.sh
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
