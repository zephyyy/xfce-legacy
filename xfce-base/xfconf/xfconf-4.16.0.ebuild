# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 gnome2-utils

DESCRIPTION="A configuration management system for Xfce"
HOMEPAGE="https://www.xfce.org/projects/"
SRC_URI="https://archive.xfce.org/src/xfce/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2+"
SLOT="0/3"
KEYWORDS="~alpha amd64 ~arm arm64 ~hppa ~ia64 ~mips ~ppc ppc64 ~sparc x86 ~amd64-linux ~x86-linux ~x64-solaris"
IUSE="debug +introspection +gsettings"

#USE=gsettings used to block dconf. let's see if it builds fine if i remove the block
RDEPEND="
	>=dev-libs/glib-2.50
	sys-apps/dbus
	>=xfce-base/libxfce4util-4.12:=
	introspection? ( dev-libs/gobject-introspection:= )
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-util/gdbus-codegen
	dev-util/glib-utils
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	default
	sed -e 's/4.14.0/4.12.0/g' -i configure
}

src_configure() {
	local myconf=(
		$(use_enable introspection)
		$(use_enable debug checks)
		$(use_enable gsettings gsettings-backend)
		--disable-vala
		--with-bash-completion-dir="$(get_bashcompdir)"
	)

	econf "${myconf[@]}"
}

src_test() {
	local service_dir=${HOME}/.local/share/dbus-1/services
	mkdir -p "${service_dir}" || die
	cat > "${service_dir}/org.xfce.Xfconf.service" <<-EOF || die
		[D-BUS Service]
		Name=org.xfce.Xfconf
		Exec=${S}/xfconfd/xfconfd
	EOF

	(
		# start isolated dbus session bus
		dbus_data=$(dbus-launch --sh-syntax) || exit
		eval "${dbus_data}"

		# -j>1 often hangs
		# https://gitlab.xfce.org/xfce/xfconf/-/issues/13
		nonfatal emake -j1 check
		ret=${?}

		kill "${DBUS_SESSION_BUS_PID}"
		exit "${ret}"
	) || die
}

src_install() {
	default
	find "${D}" -type f -name '*.la' -delete || die
	if use gsettings; then
		mkdir -p "${D}/etc/env.d"
		echo 'GSETTINGS_BACKEND=xfconf' > "${D}/etc/env.d/52xfconf" || die
	fi
}

pkg_postinst() {
	if use gsettings; then
		gnome2_giomodule_cache_update
	fi
}

pkg_postrm() {
	if use gsettings; then
		gnome2_giomodule_cache_update
	fi
}
