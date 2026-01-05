# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 xdg-utils

DESCRIPTION="Panel for the Xfce desktop environment"
HOMEPAGE="https://www.xfce.org/projects/"
EGIT_REPO_URI="https://github.com/zephyyy/${PN}.git"
EGIT_COMMIT="${PV}"

LICENSE="GPL-2+ LGPL-2.1+"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~arm64 ~hppa ~ia64 ~mips ppc ppc64 ~sparc x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="gtk3"

RDEPEND=">=dev-libs/glib-2.42
	>=x11-libs/cairo-1
	>=x11-libs/gtk+-2.20:2
	gtk3? ( >=x11-libs/gtk+-3.22:3 )
	x11-libs/libX11
	x11-libs/libwnck:1
	>=xfce-base/exo-0.8:=
	>=xfce-base/garcon-0.3:=
	>=xfce-base/libxfce4ui-4.12:=
	>=xfce-base/libxfce4util-4.12:=
	>=xfce-base/xfconf-4.13:="
BDEPEND="${RDEPEND}
	dev-lang/perl
	dev-util/gtk-doc
	dev-build/xfce4-dev-tools"

src_prepare() {
	default
	NOCONFIGURE=1 ./autogen.sh
}

src_configure() {
	local myconf=(
		$(use_enable gtk3)
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
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
