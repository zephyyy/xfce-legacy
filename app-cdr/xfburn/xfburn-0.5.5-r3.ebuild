# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg-utils

DESCRIPTION="GTK+ based CD and DVD burning application"
HOMEPAGE="https://goodies.xfce.org/projects/applications/xfburn"
SRC_URI="https://archive.xfce.org/src/apps/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm arm64 ~loong ppc ppc64 ~riscv x86"
IUSE="gstreamer +udev"

DEPEND="
	>=dev-libs/glib-2.32:=
	>=dev-libs/libburn-0.4.2:=
	>=dev-libs/libisofs-0.6.2:=
	>=x11-libs/gtk+-2.24:2=
	>=xfce-base/exo-0.10.7:=
	>=xfce-base/libxfce4ui-4.12.0:=
	gstreamer? (
		media-libs/gstreamer:1.0
		media-libs/gst-plugins-base:1.0
	)
	udev? ( dev-libs/libgudev:= )
"
BDEPEND="
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}/starting-directory.patch"
	"${FILESDIR}/fix-freebsd-crash.patch"
	"${FILESDIR}/improve-words-capitalization.patch"
	"${FILESDIR}/gcc14.patch"
)

src_configure() {
	local myconf=(
		$(use_enable udev gudev)
		$(use_enable gstreamer)
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
