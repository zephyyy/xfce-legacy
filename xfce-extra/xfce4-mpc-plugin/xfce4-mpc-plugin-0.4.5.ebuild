# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit xdg-utils

DESCRIPTION="Music Player Daemon (mpd) panel plugin"
HOMEPAGE="https://goodies.xfce.org/projects/panel-plugins/xfce4-mpc-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm ~hppa ppc ppc64 ~riscv ~sparc x86 ~amd64-linux ~x86-linux"
IUSE="+libmpd"

RDEPEND="
	>=xfce-base/exo-0.6:=
	>=xfce-base/libxfce4ui-4.8:=
	>=xfce-base/xfce4-panel-4.8:=
	libmpd? ( media-libs/libmpd:= )
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-util/intltool
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}/fix-memory-alloc.patch"
	"${FILESDIR}/fix-strings.patch"
)

src_configure() {
	local myconf=(
		$(use_enable libmpd)
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
