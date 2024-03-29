# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..11} pypy )

inherit distutils-r1

DESCRIPTION="Python library that fixes text for you"
HOMEPAGE="https://github.com/LuminosoInsight/python-ftfy"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

RDEPEND="dev-python/wcwidth"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"

distutils_enable_tests pytest
