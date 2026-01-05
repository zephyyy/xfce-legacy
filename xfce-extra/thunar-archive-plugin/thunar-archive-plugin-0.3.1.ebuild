# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools xdg-utils

DESCRIPTION="Archive plug-in for the Thunar filemanager"
HOMEPAGE="https://goodies.xfce.org/projects/thunar-plugins/thunar-archive-plugin"
SRC_URI="https://archive.xfce.org/src/thunar-plugins/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ~ia64 ppc ppc64 ~sparc x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	>=xfce-base/libxfce4util-4.8:=
	>=xfce-base/exo-0.6:=
	<xfce-base/thunar-1.7:=
"
# dev-build/xfce4-dev-tools for eautoreconf
DEPEND="${RDEPEND}"
BDEPEND="
	dev-util/intltool
	dev-build/xfce4-dev-tools
	sys-devel/gettext
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}/0.3.1-add-engrampa-support.patch"
	"${FILESDIR}/0.3.1-fix-kde-ark.patch"
	"${FILESDIR}/0.3.1-add-support-symlinks.patch"
	"${FILESDIR}/zstd-support.patch"
)
DOCS=( AUTHORS ChangeLog NEWS README THANKS )

src_prepare() {
	default
	local AT_M4DIR=${EPREFIX}/usr/share/xfce4/dev-tools/m4macros
	eautoreconf
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
