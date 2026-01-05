# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 xdg-utils

DESCRIPTION="A session manager for the Xfce desktop environment"
HOMEPAGE="https://docs.xfce.org/xfce/xfce4-session/start"
EGIT_REPO_URI="https://github.com/zephyyy/${PN}.git"
EGIT_COMMIT="${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ~arm64 ~hppa ia64 ~mips ppc ppc64 ~sparc x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="elogind nls policykit systemd +xscreensaver"

COMMON_DEPEND="
	x11-apps/iceauth
	>=dev-libs/glib-2.42
	>=x11-libs/gtk+-2.20:2
	x11-libs/libSM
	x11-libs/libwnck:1
	x11-libs/libX11
	>=xfce-base/libxfce4util-4.12:=
	>=xfce-base/libxfce4ui-4.12.1:=
	>=xfce-base/xfconf-4.14:=
	policykit? ( >=sys-auth/polkit-0.102:= )
"
RDEPEND="
	${COMMON_DEPEND}
	x11-apps/xrdb
	nls? ( x11-misc/xdg-user-dirs )
	xscreensaver? ( || (
		x11-misc/light-locker
		>=x11-misc/xscreensaver-5.26
		>=x11-misc/xlockmore-5.43
		x11-misc/slock
		x11-misc/alock[pam]
	) )
"
DEPEND="${COMMON_DEPEND}"
BDEPEND="dev-build/xfce4-dev-tools"

REQUIRED_USE="elogind? ( policykit )
	systemd? ( policykit )"

src_prepare() {
	default
	NOCONFIGURE=1 ./autogen.sh
}

src_configure() {
	local myconf=(
		$(use_enable policykit polkit)
		--with-xsession-prefix="${EPREFIX}"/usr
		--enable-maintainer-mode
	)
	econf "${myconf[@]}"
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete || die

	local sessiondir=/etc/X11/Sessions
	echo startxfce4 > "${T}"/Xfce4 || die
	exeinto ${sessiondir}
	doexe "${T}"/Xfce4
	dosym Xfce4 ${sessiondir}/Xfce
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
