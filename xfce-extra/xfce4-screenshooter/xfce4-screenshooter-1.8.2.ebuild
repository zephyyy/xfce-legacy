# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg-utils

DESCRIPTION="Xfce4 screenshooter application and panel plugin"
HOMEPAGE="https://goodies.xfce.org/projects/applications/xfce4-screenshooter"
SRC_URI="https://archive.xfce.org/src/apps/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ppc ppc64 ~sh ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	>=dev-libs/glib-2.16:=
	>=net-libs/libsoup-2.26:=
	>=x11-libs/gdk-pixbuf-2.16:=
	>=x11-libs/gtk+-2.16:2=
	dev-libs/libxml2:=
	x11-libs/libX11:=
	x11-libs/libXext:=
	x11-libs/libXfixes:=
	>=xfce-base/exo-0.6:=
	>=xfce-base/xfce4-panel-4.8:=
	>=xfce-base/libxfce4util-4.8:=
	>=xfce-base/libxfce4ui-4.8:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-util/intltool
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}/0001-Allow-and-remember-0sec-delay.patch"
)

src_prepare() {
	default
	sed -i Makefile.* -e 's,/appdata,/metainfo,'
}

src_configure() {
	local nyconf=(
		--enable-xfixes
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
