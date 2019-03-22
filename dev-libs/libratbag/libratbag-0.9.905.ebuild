# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_5,3_6,3_7} )

inherit meson udev python-r1

DESCRIPTION="Library to configure gaming mice"
HOMEPAGE="https://github.com/libratbag/libratbag"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

DEPEND="
	virtual/pkgconfig
	doc? ( app-doc/doxygen )
	test? ( dev-util/valgrind )
"
RDEPEND="
	dev-libs/libevdev
	virtual/libudev
"

src_prepare() {
	python_setup
	default
}

src_configure() {
	local emesonargs=(
		-Ddocumentation=$(usex doc true false)
		-Dtests=$(usex test true false)
		-Dudev-dir=$(get_udevdir)
	)
	meson_src_configure
}
