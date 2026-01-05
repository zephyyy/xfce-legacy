# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg-utils

DESCRIPTION="Power manager for the Xfce desktop environment"
HOMEPAGE="https://goodies.xfce.org/projects/applications/xfce4-power-manager"
SRC_URI="https://archive.xfce.org/src/xfce/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~arm64 ~ia64 ppc ppc64 x86"
IUSE="kernel_linux networkmanager +panel-plugin policykit"

COMMON_DEPEND="
	>=dev-libs/glib-2.42
	>=sys-power/upower-0.99.0
	>=x11-libs/gtk+-2.24:2
	>=x11-libs/libnotify-0.7
	x11-libs/libX11
	>=x11-libs/libXrandr-1.2
	x11-libs/libXext
	x11-libs/libXtst
	>=xfce-base/xfconf-4.12:=
	>=xfce-base/libxfce4ui-4.12:=
	>=xfce-base/libxfce4util-4.12:=
	panel-plugin? ( >=xfce-base/xfce4-panel-4.12:= )
	policykit? ( >=sys-auth/polkit-0.112 )
"
RDEPEND="
	${COMMON_DEPEND}
	networkmanager? ( net-misc/networkmanager )
"
DEPEND="${COMMON_DEPEND}"
BDEPEND="
	dev-util/intltool
	dev-build/xfce4-dev-tools
	sys-devel/gettext
	virtual/pkgconfig
	x11-base/xorg-proto
"

PATCHES=(
	"${FILESDIR}/gtk2.patch"
)

src_prepare() {
	default
	mkdir m4
	NOCONFIGURE=1 xdt-autogen
}

src_configure() {
	local myconf=(
		$(use_enable policykit polkit)
		$(use_enable networkmanager network-manager)
		$(use_enable panel-plugin xfce4panel)
		--enable-maintainer-mode
	)
	econf "${myconf[@]}"
	sed -e 's/\(xfce-power-manager-dbus.h:\).*/\1/' -i {src,settings}/Makefile || die
	sed -e 's/\(org.freedesktop.*\.h:\).*/\1/' -i {src,settings}/Makefile || die
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
