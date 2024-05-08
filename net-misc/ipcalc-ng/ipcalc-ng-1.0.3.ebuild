# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

MY_PN=${PN%%-ng}

DESCRIPTION="an IPv4/IPv6 ipcalc tool"
HOMEPAGE="https://gitlab.com/ipcalc/ipcalc"
SRC_URI="https://gitlab.com/${MY_PN}/${MY_PN}/-/archive/${PV}/${MY_PN}-${PV}.tar.bz2 -> ${P}.tar.bz2"

S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="geoip +geoip2"

DEPEND="
	geoip? ( dev-libs/geoip )
	geoip2? ( dev-libs/libmaxminddb:= )
"
RDEPEND="
	${DEPEND}
	!!net-misc/ipcalc
"
BDEPEND="
	${DEPEND}
	app-text/ronn-ng
"

REQUIRED_USE="?? ( geoip geoip2 )"

src_configure() {
	local emesonargs=(
		$(meson_feature geoip use_geoip)
		$(meson_feature geoip2 use_maxminddb)
		-Duse_runtime_linking=disabled
	)
	meson_src_configure
}
