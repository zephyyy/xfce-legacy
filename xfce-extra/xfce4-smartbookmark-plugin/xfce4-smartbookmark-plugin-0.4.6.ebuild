# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit xdg-utils

DESCRIPTION="Smart bookmark plug-in for the Xfce desktop environment"
HOMEPAGE="https://goodies.xfce.org/projects/panel-plugins/xfce4-smartbookmark-plugin"
SRC_URI="https://archive.xfce.org/src/panel-plugins/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 ppc ppc64 ~riscv x86"

RDEPEND="
	x11-libs/gtk+:2=
	x11-libs/libX11:=
	>=xfce-base/exo-0.8
	>=xfce-base/libxfce4ui-4.10:=
	>=xfce-base/xfce4-panel-4.10:=
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	default
	sed -i -e '/bugs/s:debian:gentoo:' src/smartbookmark.c || die
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
