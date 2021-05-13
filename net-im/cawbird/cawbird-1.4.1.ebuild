# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
VALA_MIN_API_VERSION=0.48

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="Cawbird is a Linux Twitter client"
HOMEPAGE="https://github.com/IBBoard/cawbird"
SRC_URI="https://github.com/IBBoard/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="corebird-icons gstreamer spellcheck"

DEPEND="dev-libs/glib
	x11-libs/gtk+:3
	net-libs/rest:0.7
	dev-libs/json-glib
	dev-db/sqlite
	net-libs/libsoup:2.4
	net-libs/liboauth
	gstreamer? (
		media-libs/gstreamer
		media-plugins/gst-plugins-gtk
		media-plugins/gst-plugins-libav
		media-plugins/gst-plugins-hls
	)
	spellcheck? ( app-text/gspell )"
RDEPEND="${DEPEND}"
BDEPEND="$(vala_depend)
	corebird-icons? ( gnome-base/librsvg )"

src_prepare() {
	default
	vala_src_prepare

	if use corebird-icons; then
		for size in 16 24 32 64 96; do
			rsvg-convert "${FILESDIR}/corebird.svg" \
				--width="${size}" --height="${size}" \
				--format=png \
				-o "${S}/data/hicolor/${size}x${size}/apps/uk.co.ibboard.cawbird.png" || die "Unable to update icons"
		done
		cp -f "${FILESDIR}/corebird.svg" "${S}/data/hicolor/scalable/apps/uk.co.ibboard.cawbird.svg" || die "Unable to copy icons"
	fi
}

src_configure() {
	local emesonargs=(
		$(meson_use gstreamer video)
		$(meson_use spellcheck)
		-Dx11=true
		-Dmswindows=false
		-Dconsumer_key_base64='VmY5dG9yRFcyWk93MzJEZmhVdEk5Y3NMOA=='
		-Dconsumer_secret_base64='MThCRXIxbWRESDQ2Y0podzVtVU13SGUyVGlCRXhPb3BFRHhGYlB6ZkpybG5GdXZaSjI='
	)
	meson_src_configure
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
