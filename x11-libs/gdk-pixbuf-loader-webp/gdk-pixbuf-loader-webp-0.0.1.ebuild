# Copyright 2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson gnome2-utils vcs-snapshot

DESCRIPTION="WebP Image format GdkPixbuf loader"
HOMEPAGE="https://github.com/aruiz/webp-pixbuf-loader"

SRC_URI="https://github.com/aruiz/webp-pixbuf-loader/archive/0.0.1.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-libs/libwebp-0.4.3
	>=x11-libs/gdk-pixbuf-2.22"
RDEPEND="${DEPEND}"

src_configure() {
	local emesonargs=(
		-Dgdk_pixbuf_query_loaders_path=/bin/true
	)
	meson_src_configure
}

pkg_preinst() {
	gnome2_gdk_pixbuf_savelist
}

pkg_postinst() {
	gnome2_gdk_pixbuf_update
}

pkg_postinst() {
	gnome2_gdk_pixbuf_update
}
