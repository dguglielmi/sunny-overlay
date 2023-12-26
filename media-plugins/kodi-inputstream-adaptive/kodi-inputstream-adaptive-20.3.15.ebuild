# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit kodi-addon

DESCRIPTION="Kodi's Adaptive inputstream addon"
HOMEPAGE="https://github.com/xbmc/inputstream.adaptive.git"

CODENAME="Nexus"
BENTO4_VERSION="1.6.0-639-7-Omega"

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

src_unpack() {
	unpack ${P}.tar.gz
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
		-DENABLE_INTERNAL_BENTO4=ON
		-DBENTO4_URL="${DISTDIR}/bento4-${BENTO4_VERSION}.tar.gz"
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)/kodi"
		-Wno-dev
	)
	cmake_src_configure
}
