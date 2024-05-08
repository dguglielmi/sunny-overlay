# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..12} )

inherit cmake python-single-r1

EGIT_COMMIT="6467c2cc52aa714876e131a1b6c6cf25f129460f"

DESCRIPTION="A Python Byte-code Disassembler/Decompiler"
HOMEPAGE="https://github.com/zrax/pycdc"
SRC_URI="https://github.com/zrax/pycdc/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/pycdc-${EGIT_COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="
	${PYTHON_DEPS}
"
RDEPEND="${BDEPEND}"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
