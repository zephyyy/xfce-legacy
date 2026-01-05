# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_P=${PN}-3.0-${PV}
DESCRIPTION="A library for registering global keyboard shortcuts"
HOMEPAGE="https://github.com/kupferlauncher/keybinder/"
SRC_URI="https://github.com/kupferlauncher/keybinder/releases/download/v${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~loong ~mips ppc ppc64 ~riscv ~sparc x86"
IUSE="+introspection"

DEPEND="
	>=x11-libs/gtk+-2.20:2
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	virtual/pkgconfig
	introspection? ( dev-libs/gobject-introspection )
"

src_configure() {
	local myconf=(
		$(use_enable introspection)
		--disable-python
		--disable-lua
	)

	econf "${myconf[@]}"
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}
