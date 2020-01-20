# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit meson udev python-r1

DESCRIPTION="Library to configure gaming mice"
HOMEPAGE="https://github.com/libratbag/libratbag"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc systemd test"

DEPEND="dev-lang/swig
	doc? ( app-doc/doxygen )
	!systemd? ( sys-auth/elogind )
	test? ( dev-util/valgrind )"
RDEPEND="dev-libs/libevdev
	virtual/libudev"
BDEPEND="virtual/pkgconfig"

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
