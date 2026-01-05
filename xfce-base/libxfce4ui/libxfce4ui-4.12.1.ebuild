# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg-utils

DESCRIPTION="Unified widget and session management libs for Xfce"
HOMEPAGE="https://git.xfce.org/xfce/libxfce4ui/"
SRC_URI="https://archive.xfce.org/src/xfce/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ~arm64 hppa ia64 ~mips ppc ppc64 ~sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="gtk3 startup-notification"

RDEPEND=">=dev-libs/glib-2.30:2=
	>=x11-libs/gtk+-2.24:2=
	x11-libs/libX11:=
	x11-libs/libICE:=
	x11-libs/libSM:=
	>=xfce-base/libxfce4util-4.12:=
	>=xfce-base/xfconf-4.12:=
	gtk3? ( >=x11-libs/gtk+-3.2:3= )
	startup-notification? ( x11-libs/startup-notification:= )
	!xfce-base/xfce-utils"
BDEPEND="${RDEPEND}
	dev-lang/perl
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/0001-Popup-menus-despite-X11-device-grab-race-conditions.patch"
	"${FILESDIR}/0002-New-function-xfce_widget_reparent.patch"
	"${FILESDIR}/0003-New-function-xfce_titled_dialog_new_with_mixed_butto.patch"
	"${FILESDIR}/gcc14.patch"
)

src_configure() {
	local myconf=(
		$(use_enable startup-notification)
		$(use_enable gtk3)
		--disable-gladeui
		--with-vendor-info=Gentoo
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
