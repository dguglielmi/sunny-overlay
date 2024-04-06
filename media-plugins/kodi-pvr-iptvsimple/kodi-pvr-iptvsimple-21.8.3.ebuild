# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake kodi-addon

DESCRIPTION="Kodi's IPTVSimple client addon"
HOMEPAGE="https://github.com/kodi-pvr/pvr.iptvsimple"
SRC_URI=""


CODENAME="Omega"
KEYWORDS="~amd64 ~x86"
SRC_URI="https://github.com/kodi-pvr/pvr.iptvsimple/archive/${PV}-${CODENAME}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pvr.iptvsimple-${PV}-${CODENAME}"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="
	dev-libs/pugixml
	=media-tv/kodi-21*
	sys-libs/zlib
	"

RDEPEND="
	${DEPEND}
	"

src_prepare() {
	[ -d depends ] && rm -rf depends || die
	cmake_src_prepare
}
