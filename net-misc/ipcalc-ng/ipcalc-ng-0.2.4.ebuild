# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils vcs-snapshot toolchain-funcs

MY_PN=${PN%%-ng}

DESCRIPTION="an IPv4/IPv6 ipcalc tool"
HOMEPAGE="https://gitlab.com/ipcalc/ipcalc"
SRC_URI="https://gitlab.com/${MY_PN}/${MY_PN}/repository/archive.tar.bz2?ref=${PV} -> ${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="geoip +geoip2"

DEPEND="!net-misc/ipcalc
	geoip? ( dev-libs/geoip )
	geoip2? ( dev-libs/libmaxminddb:= )"
RDEPEND="${DEPEND}"

REQUIRED_USE="?? ( geoip geoip2 )"

src_compile() {
	emake \
	CC="$(tc-getCC)" LIBS="${LDFLAGS}" \
	USE_GEOIP="$(usex geoip yes no)" \
	USE_MAXMIND="$(usex geoip2 yes no)" \
	USE_RUNTIME_LINKING="no"
}

src_install() {
	dobin ${MY_PN}
	doman ${MY_PN}.1
	dodoc NEWS README.md
}
