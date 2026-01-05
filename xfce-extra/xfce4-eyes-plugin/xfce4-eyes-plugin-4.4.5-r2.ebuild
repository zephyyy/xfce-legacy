# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg-utils

DESCRIPTION="A panel plug-in which adds classic eyes to your every step"
HOMEPAGE="https://goodies.xfce.org/projects/panel-plugins/xfce4-eyes-plugin"
SRC_URI="https://archive.xfce.org/src/panel-plugins/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm ~hppa ppc ppc64 ~riscv ~sparc x86 ~amd64-linux ~x86-linux"

RDEPEND="
	>=dev-libs/glib-2.20
	>=x11-libs/gtk+-2.14:2
	>=xfce-base/libxfce4ui-4.10:=
	>=xfce-base/libxfce4util-4.10:=
	<xfce-base/xfce4-panel-4.15:=
"

DEPEND="${RDEPEND}"
BDEPEND="
	dev-util/intltool
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}/add-chibi.patch"
)

src_prepare() {
	default
	cp "${FILESDIR}"/chibi-{eye,pupil}.png "${S}/themes/Chibi/"
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
