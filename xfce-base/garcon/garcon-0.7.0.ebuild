# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg-utils

DESCRIPTION="Xfce's freedesktop.org specification compatible menu implementation library"
HOMEPAGE="https://docs.xfce.org/xfce/exo/start"
SRC_URI="https://archive.xfce.org/src/xfce/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="LGPL-2+ FDL-1.1+"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~ia64 ~mips ppc ppc64 ~sparc x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

RDEPEND=">=dev-libs/glib-2.50.0
	x11-libs/gtk+:2
	>=xfce-base/libxfce4ui-4.10
	>=xfce-base/libxfce4util-4.10"
BDEPEND="
	dev-util/glib-utils
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/gtk2.patch"
)

src_prepare() {
	default
	mkdir m4
	NOCONFIGURE=1 xdt-autogen
}

src_configure() {
	DOCS=( AUTHORS ChangeLog HACKING NEWS README STATUS TODO )
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
