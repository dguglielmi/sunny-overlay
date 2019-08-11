# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_5,3_6,3_7} )

inherit gnome2 meson python-r1

DESCRIPTION="GTK application to configure gaming mice"
HOMEPAGE="https://github.com/libratbag/piper"
SRC_URI="https://github.com/libratbag/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	virtual/pkgconfig
	dev-python/pygobject:3
	>=x11-libs/gtk+-3.22:3[introspection]
"
RDEPEND="
	>=dev-libs/libratbag-0.10
	dev-python/python-evdev[${PYTHON_USEDEP}]
"
src_prepare() {
	python_setup
	default
}

src_configure() {
	meson_src_configure
}
