# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{3_5,3_6,3_7} pypy )

inherit distutils-r1

DESCRIPTION="Python library that fixes text for you"
HOMEPAGE="https://github.com/LuminosoInsight/python-ftfy"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

RDEPEND="dev-python/wcwidth"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
