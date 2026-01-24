# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit xdg-utils

DESCRIPTION="A panel plugin for showing information about cpufreq settings"
HOMEPAGE="https://goodies.xfce.org/projects/panel-plugins/xfce4-cpufreq-plugin"
SRC_URI="https://archive.xfce.org/src/panel-plugins/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm arm64 ppc ppc64 riscv x86"

RDEPEND="
	>=dev-libs/glib-2.20:=
	>=x11-libs/gtk+-2.14:2=
	>=xfce-base/libxfce4ui-4.10:=
	>=xfce-base/libxfce4util-4.10:=
	>=xfce-base/xfce4-panel-4.10:=
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}/0001-Fix-compilation-warn.patch"
	"${FILESDIR}/0002-Drop-Intel-p-state-Bug-13835.patch"
	"${FILESDIR}/0003-Prefer-sysfs-to-Intel-pstate-in-cpufreq_linux_init-B.patch"
	"${FILESDIR}/0004-Format-xfce4-cpufreq-linux.c.patch"
	"${FILESDIR}/0005-Refactor-split-cpufreq-linux.c.patch"
	"${FILESDIR}/0006-Clean-up-and-resolve-warnings.patch"
	"${FILESDIR}/0007-Check-if-each-cpu-is-online-Bug-14641.patch"
	"${FILESDIR}/0008-Fix-compilation-with-gcc-10.patch"
)

src_prepare() {
	default
	mkdir m4
	NOCONFIGURE=1 xdt-autogen
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
