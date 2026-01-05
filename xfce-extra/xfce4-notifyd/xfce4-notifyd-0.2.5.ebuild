# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 xdg-utils

DESCRIPTION="Notification daemon for the Xfce desktop environment"
HOMEPAGE="https://goodies.xfce.org/projects/applications/xfce4-notifyd"
EGIT_REPO_URI="https://github.com/zephyyy/${PN}.git"
EGIT_COMMIT="${PV}"

LICENSE="GPL-2+ LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 ~ppc ~ppc64 x86"
IUSE=""

RDEPEND="
	>=dev-libs/glib-2.42
	>=x11-libs/gtk+-2.14:2
	>=x11-libs/libnotify-0.7:=
	>=xfce-base/libxfce4ui-4.12:=
	>=xfce-base/libxfce4util-4.12:=
	>=xfce-base/xfconf-4.13:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-util/gdbus-codegen
	dev-util/glib-utils
	dev-util/intltool
	dev-build/xfce4-dev-tools
	virtual/pkgconfig
"

src_prepare() {
	default
	NOCONFIGURE=1 ./autogen.sh
}

src_configure() {
	local myconf=(
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
