# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 xdg-utils

DESCRIPTION="A panel plug-in for acpi, lm-sensors and hddtemp sensors"
HOMEPAGE="https://goodies.xfce.org/projects/panel-plugins/xfce4-sensors-plugin"
EGIT_REPO_URI="https://gitlab.xfce.org/panel-plugins/xfce4-sensors-plugin.git"
EGIT_COMMIT="ab4e1395b516b1b7e552ac54763c883b9e246ea8"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ppc ppc64"
IUSE="+acpi hddtemp libnotify lm-sensors video_cards_nvidia"

REQUIRED_USE="|| ( hddtemp lm-sensors acpi )"

RDEPEND="
	>=x11-libs/gtk+-2.20:2=
	>=xfce-base/libxfce4ui-4.12:=
	>=xfce-base/xfce4-panel-4.12:=
	hddtemp? ( app-admin/hddtemp net-analyzer/gnu-netcat )
	libnotify? ( >=x11-libs/libnotify-0.7:= )
	lm-sensors? ( >=sys-apps/lm-sensors-3.1.0:= )
	video_cards_nvidia? ( x11-drivers/nvidia-drivers[tools,static-libs] )
"
BDEPEND="
	dev-util/intltool
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}/0001-applied-patch-from-bug-14551.patch"
)

DOCS=( AUTHORS ChangeLog NEWS NOTES README TODO )

src_prepare() {
	default
	NOCONFIGURE=1 ./autogen.sh
}

src_configure() {
	local myconf=(
		--libexecdir="${EPREFIX}"/usr/$(get_libdir)
		$(use_enable lm-sensors libsensors)
		$(use_enable hddtemp)
		$(use_enable hddtemp netcat)
		$(use_enable acpi procacpi)
		$(use_enable acpi sysfsacpi)
		$(use_enable video_cards_nvidia xnvctrl)
		$(use_enable libnotify notification)
		--disable-pathchecks
	)

	econf "${myconf[@]}"
}

src_install() {
	emake DESTDIR="${D}" install manualdir="${EPREFIX}/usr/share/man/man1"
	einstalldocs
	find "${D}" -name '*.la' -delete || die
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
