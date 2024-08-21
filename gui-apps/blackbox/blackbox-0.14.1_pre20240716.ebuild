# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson vala xdg

COMMIT_ID="53be9986dea776eb4c2804d4e342cbd3a3cf06fc"

DESCRIPTION="An elegant and customizable terminal for GNOME"
HOMEPAGE="https://gitlab.gnome.org/raggesilver/blackbox"
SRC_URI="
	https://gitlab.gnome.org/raggesilver/blackbox/-/archive/${COMMIT_ID}/${PN}-${COMMIT_ID::-30}.tar.bz2
		-> ${P}.tar.bz2
"

S="${WORKDIR}/${PN}-${COMMIT_ID}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-libs/glib-2.76:2
	>=gui-libs/gtk-4.12.2:4
	>=gui-libs/libadwaita-1.4:1
	>=gui-libs/pqmarble-2
	>=gui-libs/vte-0.74.2:2.91-gtk4[vala]
	dev-libs/json-glib
	>=dev-libs/libpcre2-10.43:0=
	>=dev-libs/libxml2-2.9.12
	>=gnome-base/librsvg-2.54.0
	dev-libs/libgee
	media-libs/graphene[introspection]
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${PN}-0.14.0-rename-executable-to-backbox-terminal.patch
)

src_prepare() {
	vala_setup
	default
}

src_configure() {
	local emesonargs=(
		-Dblackbox_is_flatpak=false
	)
	meson_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
