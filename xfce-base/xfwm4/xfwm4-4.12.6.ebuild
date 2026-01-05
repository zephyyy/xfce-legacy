# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 xdg-utils

DESCRIPTION="Window manager for the Xfce desktop environment"
HOMEPAGE="https://www.xfce.org/projects/"
EGIT_REPO_URI="https://github.com/zephyyy/${PN}.git"
EGIT_COMMIT="${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86 ppc64"
IUSE="opengl startup-notification +xcomposite +xpresent"

RDEPEND="
	>=dev-libs/glib-2.20:=
	>=x11-libs/gtk+-2.24:2=
	x11-libs/libX11:=
	x11-libs/libXext:=
	x11-libs/libXinerama:=
	x11-libs/libXrandr:=
	x11-libs/libXrender:=
	x11-libs/pango:=
	>=x11-libs/libwnck-2.30:1=
	>=xfce-base/libxfce4util-4.10:=
	>=xfce-base/libxfce4ui-4.11:=
	|| (
		>=xfce-base/xfconf-4.13:=
		(
			dev-libs/dbus-glib:=
			>=xfce-base/xfconf-4.12:=
		)
	)
	opengl? ( media-libs/libepoxy:=[X(+)] )
	startup-notification? ( x11-libs/startup-notification:= )
	xpresent? ( x11-libs/libXpresent )
	xcomposite? (
		x11-libs/libXcomposite:=
		x11-libs/libXdamage:=
		x11-libs/libXfixes:=
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-util/intltool
	dev-build/xfce4-dev-tools
	sys-devel/gettext
	x11-libs/libICE
	x11-libs/libSM
	virtual/pkgconfig
"

DOCS=( AUTHORS COMPOSITOR NEWS README TODO )

src_prepare() {
	default
	NOCONFIGURE=1 ./autogen.sh
}

src_configure() {
	local myconf=(
		$(use_enable opengl epoxy)
		$(use_enable startup-notification)
		--enable-xsync
		--enable-render
		--enable-randr
		$(use_enable xpresent)
		$(use_enable xcomposite compositor)
		--enable-maintainer-mode
	)

	econf "${myconf[@]}"
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete || die
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
