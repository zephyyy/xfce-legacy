# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A tool to find and launch installed applications for the Xfce desktop"
HOMEPAGE="https://docs.xfce.org/xfce/xfce4-appfinder/start"
SRC_URI="https://archive.xfce.org/src/xfce/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm arm64 ~hppa ~ia64 ~mips ~ppc ppc64 ~sparc x86"
IUSE=""

RDEPEND="
	>=dev-libs/glib-2.30:=
	>=x11-libs/gtk+-2.24:2=
	>=xfce-base/garcon-0.3:=
	>=xfce-base/libxfce4util-4.11:=
	>=xfce-base/libxfce4ui-4.11:=
	>=xfce-base/xfconf-4.10:=
	!xfce-base/xfce-utils
"
BDEPEND="
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}/0001-Use-non-legacy-icon-names.patch"
	"${FILESDIR}/gcc14.patch"
)

src_prepare() {
	default
	sed -i data/Makefile.* -e 's,/appdata,/metainfo,'
}
