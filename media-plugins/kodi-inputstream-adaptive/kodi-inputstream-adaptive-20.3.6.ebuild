# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake kodi-addon

DESCRIPTION="Kodi's Adaptive inputstream addon"
HOMEPAGE="https://github.com/xbmc/inputstream.adaptive.git"

CODENAME="Nexus"
BENTO4_VERSION="1.6.0-639-6-${CODENAME}"

KEYWORDS="~amd64 ~x86"
SRC_URI="https://github.com/xbmc/inputstream.adaptive/archive/${PV}-${CODENAME}.tar.gz -> ${P}.tar.gz
	https://github.com/xbmc/Bento4/archive/${BENTO4_VERSION}.tar.gz -> bento4-${BENTO4_VERSION}.tar.gz"
S="${WORKDIR}/inputstream.adaptive-${PV}-${CODENAME}"

LICENSE="GPL-2"
SLOT="0"
RESTRICT="!test? ( test )"
IUSE="test"

COMMON_DEPEND="
	dev-libs/expat
	=media-tv/kodi-20*
	"
DEPEND="
	${COMMON_DEPEND}
	test? ( dev-cpp/gtest )
	"
RDEPEND="
	${COMMON_DEPEND}
	"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
		-DENABLE_INTERNAL_BENTO4=ON
		-DBENTO4_URL="${DISTDIR}/bento4-${BENTO4_VERSION}.tar.gz"
	)
	cmake_src_configure
}
