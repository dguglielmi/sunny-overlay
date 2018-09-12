# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils toolchain-funcs

MY_PN=${PN%%-ng}

DESCRIPTION="an IPv4/IPv6 ipcalc tool"
HOMEPAGE="https://github.com/nmav/ipcalc"
SRC_URI="https://github.com/nmav/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+geoip"

S="${WORKDIR}/${MY_PN}-${PV}"

DEPEND="!net-misc/ipcalc
	geoip? ( dev-libs/geoip )"
RDEPEND="${DEPEND}"

src_compile() {
	emake \
	CC="$(tc-getCC)" LIBS="${LDFLAGS}" \
	USE_GEOIP="$(usex geoip yes no)" \
	USE_DYN_GEOIP="no"
}

src_install() {
	dobin ${MY_PN}
	doman ${MY_PN}.1
	dodoc NEWS README.md
}
