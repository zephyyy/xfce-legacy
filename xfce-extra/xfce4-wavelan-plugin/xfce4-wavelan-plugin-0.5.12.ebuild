# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit xdg-utils

DESCRIPTION="A panel plug-in to display wireless interface statistics"
HOMEPAGE="https://goodies.xfce.org/projects/panel-plugins/xfce4-wavelan-plugin"
SRC_URI="https://archive.xfce.org/src/panel-plugins/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm ~hppa ppc ppc64 ~riscv ~sparc x86 ~amd64-linux ~x86-linux"
IUSE="kernel_linux"

DEPEND="
	>=xfce-base/libxfce4ui-4.8:=
	>=xfce-base/libxfce4util-4.8:=
	>=xfce-base/xfce4-panel-4.8:=
"
RDEPEND="
	${DEPEND}
	kernel_linux? ( sys-apps/net-tools )
"
BDEPEND="
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig
"

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
