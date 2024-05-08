# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.56
VALA_USE_DEPEND=vapigen

inherit vala gnome2-utils

DESCRIPTION="Dock panel famious docky"
HOMEPAGE="https://launchpad.net/plank"
SRC_URI="http://launchpad.net/${PN}/$(ver_cut 1-2)/${PV}/+download/${P}.tar.xz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+introspection doc static-libs"

DEPEND="
	gnome-base/gnome-common
	>=sys-devel/gettext-0.19.6
	>=dev-libs/glib-2.32:2
	dev-libs/libgee:0.8
	x11-libs/gtk+:3
	x11-libs/bamf
	x11-libs/libX11
	dev-libs/libdbusmenu
	x11-libs/libwnck:3
"
BDEPEND="
	${DEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

DOCS=( AUTHORS COPYRIGHT )

PATCHES=(
	"${FILESDIR}"/${P}-allow-building-with-gettext-0.20.patch
)

src_prepare() {
	vala_setup
	NOCONFIGURE=1 REQUIRED_PKG_CONFIG_VERSION=0.1 ./autogen.sh
	default
}

src_install() {
	default
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
