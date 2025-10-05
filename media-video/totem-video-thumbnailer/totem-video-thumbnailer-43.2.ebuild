# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="GNOME Video thumbnailer"
HOMEPAGE="https://gitlab.gnome.org/GNOME/totem-video-thumbnailer/"

SRC_URI="https://download.gnome.org/sources/totem/${PV::2}/totem-${PV}.tar.xz"

LICENSE="GPL-2+"

SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~loong ~ppc ~ppc64 ~riscv ~x86"

COMMON_DEPEND="
	!media-video/totem
	>=dev-libs/glib-2.72.0:2
	>=media-libs/gstreamer-1.21.1:1.0
	>=dev-libs/totem-pl-parser-3.26.5
	x11-libs/gdk-pixbuf:2
"

RDEPEND="${COMMON_DEPEND}
	>=media-plugins/gst-plugins-meta-1.21.1:1.0
	>=media-plugins/gst-plugins-taglib-1.21.1:1.0
"
DEPEND="${COMMON_DEPEND}"

BDEPEND="
	>=sys-devel/gettext-0.19.8
	virtual/pkgconfig
"

src_unpack() {
	mkdir -p "${S}"/submodules || die
	cp "${FILESDIR}"/meson.build "${S}/" || die

	default
}

src_prepare() {
	ln -s "${WORKDIR}"/totem-${PV} "${S}"/submodules/totem || die

	default
}
