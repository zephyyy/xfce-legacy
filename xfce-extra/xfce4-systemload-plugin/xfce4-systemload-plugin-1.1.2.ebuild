# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit xdg-utils

DESCRIPTION="System load plug-in for Xfce panel"
HOMEPAGE="https://goodies.xfce.org/projects/panel-plugins/xfce4-systemload-plugin"
SRC_URI="https://archive.xfce.org/src/panel-plugins/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm ~hppa ppc ppc64 ~riscv ~sparc x86 ~amd64-linux ~x86-linux"
IUSE="upower"

RDEPEND="
	>=x11-libs/gtk+-2.6:2=
	>=xfce-base/libxfce4ui-4.10:=
	>=xfce-base/libxfce4util-4.10:=
	>=xfce-base/xfce4-panel-4.10:=
	upower? ( >=sys-power/upower-0.9.23:= )
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-util/intltool
	virtual/pkgconfig
"

src_configure() {
	local myconf=(
		$(use_enable upower)
	)

	econf "${myconf[@]}"
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
