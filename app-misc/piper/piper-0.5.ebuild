# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9} )

inherit meson python-r1 xdg-utils

DESCRIPTION="GTK application to configure gaming mice"
HOMEPAGE="https://github.com/libratbag/piper"
SRC_URI="https://github.com/libratbag/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/pygobject:3
	>=x11-libs/gtk+-3.22:3[introspection]"
RDEPEND=">=dev-libs/libratbag-0.10
	dev-python/python-evdev[${PYTHON_USEDEP}]"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	python_setup
	default
}

src_configure() {
	meson_src_configure
}

src_install() {
	meson_src_install
	python_optimize "${D}"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
