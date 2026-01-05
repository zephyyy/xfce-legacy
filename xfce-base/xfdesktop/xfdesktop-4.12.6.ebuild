# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 xdg-utils

DESCRIPTION="Desktop manager for the Xfce desktop environment"
HOMEPAGE="https://www.xfce.org/projects/"
EGIT_REPO_URI="https://github.com/zephyyy/${PN}.git"
EGIT_COMMIT="${PV}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~arm64 ~hppa ~ia64 ~mips ppc ppc64 ~sparc x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="libnotify +thunar"

RDEPEND="
	>=x11-libs/cairo-1.12
	>=dev-libs/glib-2.42
	>=x11-libs/gtk+-2.24:2
	>=x11-libs/libwnck-2.30:1
	x11-libs/libX11
	xfce-base/exo
	>=xfce-base/garcon-0.3:=
	>=xfce-base/libxfce4ui-4.11:=
	>=xfce-base/libxfce4util-4.11:=
	>=xfce-base/xfconf-4.10:=
	libnotify? ( >=x11-libs/libnotify-0.7:= )
	thunar? ( =xfce-base/thunar-1.6*:= )
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-util/gdbus-codegen
	dev-util/glib-utils
	dev-util/intltool
	dev-build/xfce4-dev-tools
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	default
	NOCONFIGURE=1 ./autogen.sh
}

src_configure() {
	local myconf=(
		$(use_enable thunar file-icons)
		$(use_enable thunar thunarx)
		$(use_enable libnotify notifications)
		--enable-maintainer-mode
	)
	econf "${myconf[@]}"
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
