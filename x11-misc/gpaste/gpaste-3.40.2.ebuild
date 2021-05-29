# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION="0.42"
VALA_USE_DEPEND="vapigen"

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="Clipboard management system"
HOMEPAGE="https://github.com/Keruspe/GPaste"
SRC_URI="https://github.com/Keruspe/GPaste/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X bash-completion gnome introspection systemd vala zsh-completion"

DEPEND="dev-libs/appstream-glib
	>=dev-libs/gjs-1.54.0
	>=dev-libs/glib-2.58:2
	>=dev-libs/gobject-introspection-1.58.0
	sys-apps/dbus
	>=x11-libs/gdk-pixbuf-2.38:2
	>=x11-libs/gtk+-3.24:3
	X? (
		x11-libs/libX11
		x11-libs/libXi
	)
	gnome? (
		gnome-base/gnome-control-center:2
		media-libs/clutter
		x11-libs/pango
		>=x11-wm/mutter-40.1:0/8
	)
	systemd? ( sys-apps/systemd )"
RDEPEND="${DEPEND}
	gnome? ( gnome-base/gnome-shell )"
BDEPEND="vala? ( $(vala_depend) )
	virtual/pkgconfig"

REQUIRED_USE="vala? ( introspection )"

S="${WORKDIR}/GPaste-${PV}"

src_prepare() {
	default
	if use vala; then
		vala_src_prepare
	fi
}

src_configure() {
	local emesonargs=(
		$(meson_use X x-keybinder)
		$(meson_use bash-completion)
		$(meson_use gnome gnome-shell)
		$(meson_use introspection)
		$(meson_use systemd)
		$(meson_use vala vapi)
		$(meson_use zsh-completion)
		-Dcontrol-center-keybindings-dir=$(usex gnome '' \
		'/usr/share/gnome-control-center/keybindings')
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	find "${D}" -name '*.la' -delete || die
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_desktop_database_update
	xdg_icon_cache_update
}
