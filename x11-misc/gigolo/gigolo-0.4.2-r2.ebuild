# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg-utils

DESCRIPTION="a frontend to easily manage connections to remote filesystems using GIO/GVfs"
HOMEPAGE="https://www.uvena.de/gigolo/ https://goodies.xfce.org/projects/applications/gigolo"
SRC_URI="https://archive.xfce.org/src/apps/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ppc ppc64 ~sparc x86"
IUSE=""

RDEPEND="
	>=dev-libs/glib-2.16
	>=x11-libs/gtk+-2.12:2
"
BDEPEND="
	dev-util/intltool
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}"/mr5.patch
	"${FILESDIR}"/fix-typo.patch
	"${FILESDIR}"/migrate-gvfs-to-gio.patch
)

src_prepare() {
	rm -f COPYING || die
	default
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
