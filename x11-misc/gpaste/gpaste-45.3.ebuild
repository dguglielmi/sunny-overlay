# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION="0.42"
VALA_USE_DEPEND="vapigen"

inherit meson vala gnome2-utils

DESCRIPTION="Clipboard management system"
HOMEPAGE="https://github.com/Keruspe/GPaste"
SRC_URI="https://github.com/Keruspe/GPaste/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/GPaste-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+gnome +introspection systemd vala"

REQUIRED_USE="
	gnome? ( introspection )
	vala? ( introspection )
"

DEPEND="
	>=gui-libs/libadwaita-1.1
	>=app-crypt/gcr-3.90.0:4
	>=x11-libs/gdk-pixbuf-2.38.0:2
	>=dev-libs/glib-2.70.0:2
	sys-apps/dbus
	>=x11-libs/gtk+-3.24:3
	>=gui-libs/gtk-4.6.0:4
	gnome? (
		>=x11-wm/mutter-41.3
		x11-libs/pango
		>=dev-libs/gjs-1.78.0
	)
	introspection? (
		>=dev-libs/gobject-introspection-1.48.0
		>=x11-wm/mutter-41.3[introspection]
	)
"
BDEPEND="
	virtual/pkgconfig
	gnome? (
		gnome-base/gnome-control-center:2
	)
	systemd? (
		sys-apps/systemd
	)
	vala? ( $(vala_depend) )
"
RDEPEND="${DEPEND}
	gnome? (
		gnome-base/gnome-control-center:2
		gnome-base/gnome-shell
	)
	systemd? (
		sys-apps/systemd
	)
"

src_prepare() {
	use vala && vala_setup
	default
}

src_configure() {
	local emesonargs=(
		$(meson_use systemd systemd)
		-Dbash-completion=true
		-Dzsh-completion=true
		-Dx-keybinder=true
		-Dcontrol-center-keybindings-dir=$(usex gnome '' \
		'/usr/share/gnome-control-center/keybindings')
		$(meson_use introspection introspection)
		$(meson_use vala vapi)
		$(meson_use gnome gnome-shell)
	)
	meson_src_configure
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
