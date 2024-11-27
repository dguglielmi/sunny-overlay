# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="C++ library for DJ record libraries"
HOMEPAGE="https://github.com/xsco/libdjinterop"
SRC_URI="https://github.com/xsco/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

IUSE="test"

DEPEND="
	dev-db/sqlite
	sys-libs/zlib
"
RDEPEND="${DEPEND}"
BDEPEND="
	${DEPEND}
	test? ( dev-libs/boost )
"

RESTRICT="!test? ( test )"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_SKIP_BUILD_RPATH=ON
		-Wno-dev
	)
	cmake_src_configure
}
