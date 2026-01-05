# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The Xfce Desktop Environment (meta package)"
HOMEPAGE="https://www.xfce.org/"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm arm64 ~loong ~ppc ppc64 ~riscv x86"
IUSE="
	archive calendar cdr editor image media minimal mpd pulseaudio
	remote-fs search +svg upower
"

RDEPEND="
	>=x11-themes/gtk-engines-xfce-3:0
	x11-themes/hicolor-icon-theme
	<xfce-base/exo-0.12.12
	<xfce-base/garcon-0.7.1
	<xfce-base/libxfce4ui-4.13.0
	<xfce-base/libxfce4util-4.13.0
	<xfce-base/thunar-1.7.0
	<xfce-base/thunar-volman-0.9.0
	<xfce-base/tumbler-4.13.0
	<xfce-base/xfce4-appfinder-4.13.0
	<xfce-base/xfce4-panel-4.13.0
	<xfce-base/xfce4-session-4.13.0
	<xfce-base/xfce4-settings-4.13.0
	<x11-terms/xfce4-terminal-0.7.0
	<xfce-base/xfconf-4.16.1
	<xfce-base/xfdesktop-4.13.0
	<xfce-base/xfwm4-4.13.0
	!minimal? (
		media-fonts/dejavu
		virtual/freedesktop-icon-theme
	)
	archive? ( app-arch/xarchiver )
	calendar? ( <app-office/orage-4.12.2 )
	cdr? ( <app-cdr/xfburn-0.5.6 )
	editor? ( <app-editors/mousepad-0.5.0 )
	image? ( <media-gfx/ristretto-0.8.6 )
	media? ( media-video/parole )
	mpd? ( <media-sound/xfmpc-0.2.4 )
	pulseaudio? ( <xfce-extra/xfce4-volumed-pulse-0.2.3 )
	remote-fs? ( <x11-misc/gigolo-0.4.3 )
	search? ( dev-util/catfish )
	svg? ( gnome-base/librsvg )
	upower? ( <xfce-base/xfce4-power-manager-1.7.0 )
"
