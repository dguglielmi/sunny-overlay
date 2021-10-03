# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit cmake python-single-r1

EGIT_COMMIT="fbf9d24de3e5322d75658c0733afd5b139280ad8"

DESCRIPTION="A Python Byte-code Disassembler/Decompiler"
HOMEPAGE="https://github.com/zrax/pycdc"
SRC_URI="https://github.com/zrax/pycdc/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="${PYTHON_DEPS}"

S="${WORKDIR}/pycdc-${EGIT_COMMIT}"
