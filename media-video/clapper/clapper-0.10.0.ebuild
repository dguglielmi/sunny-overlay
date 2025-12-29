# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION="0.56"
VALA_USE_DEPEND="vapigen"

inherit meson vala gnome2-utils

DESCRIPTION="Modern media player designed for simplicity"
HOMEPAGE="https://github.com/Rafostar/clapper"
SRC_URI="
	https://github.com/Rafostar/clapper/archive/${PV}.tar.gz
		-> ${P}.tar.gz
"

LICENSE="GPL-3 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

IUSE="doc gstreamer introspection plugins +server vala"

REQUIRED_USE="doc? ( introspection )"

DEPEND="
	>=dev-libs/glib-2.76.0
	>=media-libs/gstreamer-1.24.0:=
	>=gui-libs/gtk-4.10.0
	>=gui-libs/libadwaita-1.5.0
	>=media-libs/gst-plugins-base-1.24.0
	introspection? ( dev-libs/gobject-introspection )
	plugins? ( dev-libs/libpeas:2 )
	server? (
		net-libs/libsoup:3.0
		net-libs/libmicrodns
	)
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-libs/appstream-glib
	vala? ( $(vala_depend) )
	doc? (
		dev-util/gi-docgen
		media-gfx/graphviz
	)
"

src_prepare() {
	use vala && vala_setup
	default
}

src_configure() {
	local emesonargs=(
		-Dclapper=enabled
		-Dclapper-gtk=enabled
		-Dclapper-app=enabled
		$(meson_feature gstreamer gst-plugin)
		$(meson_feature introspection)
		$(meson_feature vala vapi)
		$(meson_use doc)
		$(meson_feature plugins enhancers-loader)
		-Ddiscoverer=enabled
		-Dmpris=enabled
		$(meson_feature server)
		$(meson_feature gstreamer glimporter)
		$(meson_feature gstreamer gluploader)
		$(meson_feature gstreamer rawimporter)
	)
	meson_src_configure
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}
