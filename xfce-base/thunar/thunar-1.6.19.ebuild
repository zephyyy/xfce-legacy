# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 xdg-utils

DESCRIPTION="File manager for the Xfce desktop environment"
HOMEPAGE="https://www.xfce.org/projects/ https://docs.xfce.org/xfce/thunar/start"
EGIT_REPO_URI="https://github.com/zephyyy/${PN}.git"
EGIT_COMMIT="${PV}"

LICENSE="GPL-2+ LGPL-2+"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~arm64 ~ia64 ~mips ppc ppc64 ~sparc x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="exif libnotify pcre test +trash-panel-plugin udisks"

GVFS_DEPEND=">=gnome-base/gvfs-1.18.3"
COMMON_DEPEND=">=dev-lang/perl-5.6
	>=dev-libs/glib-2.42
	>=x11-libs/gdk-pixbuf-2.14
	>=x11-libs/gtk+-2.24:2
	xfce-base/exo
	>=xfce-base/libxfce4ui-4.12:=
	>=xfce-base/libxfce4util-4.12:=
	>=xfce-base/xfconf-4.12:=
	exif? ( >=media-libs/libexif-0.6.19:= )
	libnotify? ( >=x11-libs/libnotify-0.7 )
	pcre? ( >=dev-libs/libpcre-6:= )
	trash-panel-plugin? ( >=xfce-base/xfce4-panel-4.10:= )
	udisks? ( dev-libs/libgudev:= )"
RDEPEND="${COMMON_DEPEND}
	>=dev-util/desktop-file-utils-0.20-r1
	x11-misc/shared-mime-info
	trash-panel-plugin? ( ${GVFS_DEPEND} )
	udisks? (
		virtual/udev
		${GVFS_DEPEND}[udisks,udev]
		)"
BDEPEND="${COMMON_DEPEND}
	dev-util/gdbus-codegen
	dev-util/glib-utils
	dev-util/intltool
	dev-build/xfce4-dev-tools
	sys-devel/gettext
	virtual/pkgconfig"

DOCS=( AUTHORS FAQ HACKING NEWS README THANKS TODO )

src_prepare() {
	default
	NOCONFIGURE=1 ./autogen.sh
}

src_configure() {
	local myconf=(
		$(use_enable udisks gudev)
		$(use_enable libnotify notifications)
		$(use_enable exif)
		$(use_enable pcre)
		$(use_enable trash-panel-plugin tpa-plugin)
		--enable-maintainer-mode
	)

	econf "${myconf[@]}"
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
