# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="C++ library for DJ record libraries"
HOMEPAGE="https://github.com/xsco/libdjinterop"
SRC_URI="https://github.com/xsco/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"

DEPEND="dev-db/sqlite
	sys-libs/zlib
	test? ( dev-libs/boost )"
RDEPEND="${DEPEND}"
BDEPEND=""
