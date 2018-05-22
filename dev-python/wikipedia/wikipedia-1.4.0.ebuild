# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} pypy )

inherit distutils-r1

DESCRIPTION="Python library that makes it easy to access and parse data from Wikipedia"
HOMEPAGE="https://github.com/goldsmith/Wikipedia"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

RDEPEND="
	dev-python/beautifulsoup:4
	>=dev-python/requests-2.6.0
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
