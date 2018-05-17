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
IUSE="+geoip +static"

S="${WORKDIR}/${MY_PN}-${PV}"

DEPEND="!net-misc/ipcalc
	geoip? ( dev-libs/geoip )"
RDEPEND="${DEPEND}"

PATCHES=(
	${FILESDIR}/${P}-fix-geoip-linking.patch
	${FILESDIR}/${P}-ipcalc-h-guard-header.patch
)

src_compile() {
	CC="$(tc-getCC)" LIBS="${LDFLAGS}" LIBPATH="${EPREFIX}/usr/$(get_libdir)" \
	USE_GEOIP="$(usex geoip yes no)" \
	USE_DYN_GEOIP="no" \
	emake
}

src_install() {
	dobin ${MY_PN}
	doman ${MY_PN}.1
	dodoc NEWS README.md
}
