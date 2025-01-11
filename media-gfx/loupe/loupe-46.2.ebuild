# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo gnome.org gnome2-utils meson xdg

DESCRIPTION="An image viewer application written with GTK 4, Libadwaita and Rust"
HOMEPAGE="https://apps.gnome.org/Loupe/"

LICENSE="GPL-3+"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 MIT
	Unicode-DFS-2016
	|| ( LGPL-2.1+ MPL-2.0 )
"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	>=gui-libs/gtk-4.13.6:4
	>=gui-libs/libadwaita-1.4.0
	>=dev-libs/libgweather-4.2.0
	>=media-libs/lcms-2.12.0:2
	>=sys-libs/libseccomp-2.5.0
"
RDEPEND="
	${DEPEND}
	>=media-libs/glycin-loaders-1.1.2
"
BDEPEND="${DEPEND}"

ECARGO_VENDOR="${S}/vendor"

src_configure() {
	meson_src_configure
	ln -s "${CARGO_HOME}" "${BUILD_DIR}/cargo-home" || die
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
