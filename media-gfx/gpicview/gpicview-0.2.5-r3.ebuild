# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg

DESCRIPTION="A Simple and Fast Image Viewer for X"
HOMEPAGE="https://lxde.sourceforge.net/gpicview/"
SRC_URI="https://downloads.sourceforge.net/lxde/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ppc64 ppc ~riscv x86"
IUSE="gtk3"

RDEPEND="
	media-libs/libjpeg-turbo
	gtk3?  ( x11-libs/gtk+:3[X] )
	!gtk3? ( x11-libs/gtk+:2 )
"
BDEPEND="
	>=dev-util/intltool-0.40
	sys-devel/gettext
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}/${PN}-main_win_open-dummy-return.patch"
	"${FILESDIR}/${PN}-fix-animated-gifs.patch"
)

src_prepare() {
	default
	
	if use gtk3 ; then
		eapply "${FILESDIR}/Fix-displaying-images-with-GTK3.patch"
	fi
}

src_configure() {
	if use gtk3 ; then
		econf $(use_enable gtk3)
	else
		econf
	fi
}
