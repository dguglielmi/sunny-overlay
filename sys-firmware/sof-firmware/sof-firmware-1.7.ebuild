# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Sound Open Firmware (SOF) binary files"

HOMEPAGE="https://www.sofproject.org https://github.com/thesofproject/sof https://github.com/thesofproject/sof-bin"
SRC_URI="https://github.com/thesofproject/sof-bin/archive/refs/tags/v1.7.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S=${WORKDIR}/sof-bin-${PV}

src_install() {
	mkdir -p ${D}/lib/firmware/intel || die

	cp -rf sof-v${PV} ${D}/lib/firmware/intel/sof || die
	cp -rf sof-tplg-v${PV} ${D}/lib/firmware/intel/sof-tplg || die
}
