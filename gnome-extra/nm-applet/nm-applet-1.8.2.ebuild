# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
GNOME2_LA_PUNT="yes"
GNOME2_EAUTORECONF="yes"

inherit gnome2

DESCRIPTION="GNOME applet for NetworkManager"
HOMEPAGE="https://github.com/jlindgren90/network-manager-applet-gtk2"
COMMIT="5b6c92d48ea0574b4c82721b3e775b44aaf0d422"
SRC_URI="${HOMEPAGE}/archive/${COMMIT}.tar.gz -> ${PN}-gtk2-${PVR}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
IUSE="appindicator +introspection +modemmanager teamd"
KEYWORDS="~alpha amd64 ~arm ~arm64 ~ia64 ppc ppc64 ~sparc x86"

RDEPEND="
	>=app-crypt/libsecret-0.18
	>=dev-libs/glib-2.38:2[dbus]
	>=dev-libs/dbus-glib-0.88
	dev-libs/libgudev:=
	>=sys-apps/dbus-1.4.1
	>=sys-auth/polkit-0.96-r1
	>=x11-libs/gtk+-2.24:2[introspection?]
	>=x11-libs/libnotify-0.7.0

	app-text/iso-codes
	>=net-misc/networkmanager-1.7:=[introspection?,modemmanager?,teamd?]
	net-misc/mobile-broadband-provider-info

	appindicator? (
		dev-libs/libappindicator:2
		>=dev-libs/libdbusmenu-16.04.0
	)
	introspection? ( >=dev-libs/gobject-introspection-0.9.6:= )
	virtual/freedesktop-icon-theme
	modemmanager? ( net-misc/modemmanager )
	teamd? ( >=dev-libs/jansson-2.7 )
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-util/gtk-doc
	>=dev-build/gtk-doc-am-1.0
	>=sys-devel/gettext-0.18
	virtual/pkgconfig
"
PDEPEND="virtual/notification-daemon" #546134

PATCHES=(
	"${FILESDIR}/fix-build-scripts.patch"
	"${FILESDIR}/fix-separators.patch"
)

src_unpack() {
	default
	mv "${HOMEPAGE##*/}-${COMMIT}" "${P}"
}

src_prepare() {
	if use appindicator; then
		sed -e 's/Exec=nm-applet/Exec=nm-applet --indicator/' -i nm-applet.desktop.in || die
	fi
	gnome2_src_prepare
}

src_configure() {
	local myconf=(
		--without-libnm-gtk
		--disable-lto
		--disable-ld-gc
		--disable-more-warnings
		--disable-static
		--localstatedir=/var
		$(use_with appindicator)
		$(use_enable introspection)
		$(use_with modemmanager wwan)
		$(use_with teamd team)
	)
	gnome2_src_configure "${myconf[@]}"
}
