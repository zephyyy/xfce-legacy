# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit xdg-utils

DESCRIPTION="Daemon to control volume up/down and mute keys for pulseaudio"
HOMEPAGE="https://git.xfce.org/apps/xfce4-volumed-pulse/"
SRC_URI="https://archive.xfce.org/src/apps/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="libnotify"

RDEPEND="
	>=dev-libs/glib-2.16:2=
	dev-libs/keybinder:0=
	>=media-libs/libpulse-0.9.19:=[glib]
	>=x11-libs/gtk+-2.20:2=
	>=xfce-base/xfconf-4.8:=
	libnotify? ( x11-libs/libnotify:= )
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

DOCS=( AUTHORS ChangeLog README THANKS )

src_prepare() {
	default
	NOCONFIGURE=1 xdt-autogen
}

src_configure() {
	local myconf=(
		$(use_enable libnotify libnotify)
	)
	econf "${myconf[@]}"
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}
