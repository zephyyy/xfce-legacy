# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 autotools

DESCRIPTION="Font viewer utility for MATE Desktop"
EGIT_REPO_URI="https://github.com/mate-desktop/mate-control-center.git"
EGIT_CLONE_TYPE="shallow"
EGIT_COMMIT="v1.22.0"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86 ppc64"

IUSE="debug"

COMMON_DEPEND="
	dev-libs/atk
	>=dev-libs/dbus-glib-0.73
	>=dev-libs/glib-2.50:2
	dev-libs/libxml2:2
	>=gnome-base/dconf-0.13.4
	>=gnome-base/librsvg-2.0:2
	>=media-libs/fontconfig-1:1.0
	media-libs/freetype:2
	>=sys-apps/dbus-1
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-3.22:3
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXext
	>=x11-libs/libXi-1.5
	x11-libs/pango
	media-libs/libcanberra
	virtual/libintl
"
RDEPEND="
	${COMMON_DEPEND}
	!mate-base/mate-control-center
"
BDEPEND="
	>=mate-base/mate-common-1.22.0
	>=app-text/scrollkeeper-dtd-1:1.0
	app-text/yelp-tools
	dev-util/desktop-file-utils
	>=dev-util/intltool-0.50.1
	sys-devel/gettext:*
	x11-base/xorg-proto
	virtual/pkgconfig:*
"

src_prepare() {
	patch -Np1 -i "${FILESDIR}/mcc.patch"
	AT_NOELIBTOOLIZE="yes" eautoreconf
	eapply_user
}

src_configure() {
	econf \
		--enable-maintainer-mode \
		--disable-update-mimedb \
		--disable-appindicator \
		--without-accountsservice \
		$(use_enable debug)
}

src_install() {
	default
	while read -r f; do rm "${D}/${f}"; done < "${FILESDIR}/mcc-delete.list"
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
