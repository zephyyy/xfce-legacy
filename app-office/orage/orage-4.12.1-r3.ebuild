# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg-utils

DESCRIPTION="A time managing application (and panel plug-in) for the Xfce desktop environment"
HOMEPAGE="https://git.xfce.org/apps/orage/"
SRC_URI="https://archive.xfce.org/src/apps/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ppc ppc64 ~sparc x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="berkdb +clock-panel-plugin dbus libnotify"

RDEPEND="
    >=dev-libs/libical-0.48:=
	dev-libs/popt:=
	>=x11-libs/gtk+-2.10:2=
	berkdb? ( >=sys-libs/db-4:= )
	clock-panel-plugin? ( <xfce-base/xfce4-panel-4.15:=[gtk2(+)] )
	dbus? ( >=dev-libs/dbus-glib-0.100:= )
	libnotify? ( >=x11-libs/libnotify-0.7:= )
"
BDEPEND="
	dev-util/intltool
	sys-devel/gettext
	>=dev-build/libtool-2.2.6
	virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}"/0001-fix-build-with-libical-version-3.patch
	"${FILESDIR}"/gcc14.patch
)

src_configure() {
	local myconf=(
		--libexecdir="${EPREFIX}/usr/$(get_libdir)"
		--docdir="${EPREFIX}"/usr/share/doc/${PF}/html
		$(use_enable clock-panel-plugin libxfce4panel)
		$(use_enable dbus)
		$(use_enable libnotify)
		$(use_with berkdb bdb4)
	)

	econf "${myconf[@]}"
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}

pkg_preinst() {
	# Replacing directory by symlink is unreliable
	if [[ -L ${EROOT}/usr/share/orage/doc/C ]]; then
		rm -f "${EROOT}/usr/share/orage/doc/C" || die
	fi
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
