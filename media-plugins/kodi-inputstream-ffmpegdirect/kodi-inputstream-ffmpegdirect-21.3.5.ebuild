# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit kodi-addon

DESCRIPTION="Kodi's FFMpeg Direct Inputstream addon"
HOMEPAGE="https://github.com/xbmc/inputstream.ffmpegdirect"
SRC_URI=""

KEYWORDS="~amd64 ~arm ~arm64 ~x86"
CODENAME="Omega"
SRC_URI="https://github.com/xbmc/inputstream.ffmpegdirect/archive/${PV}-${CODENAME}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/inputstream.ffmpegdirect-${PV}-${CODENAME}"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

BDEPEND="
	virtual/pkgconfig
	"

COMMON_DEPEND="
	media-video/ffmpeg:=[encode,libxml2,zlib]
	virtual/libiconv
	app-arch/bzip2
	=media-tv/kodi-21*
	"

DEPEND="
	${COMMON_DEPEND}
	"

RDEPEND="
	${COMMON_DEPEND}
	"

src_prepare() {
	[ -d depends ] && rm -rf depends || die
	cmake_src_prepare
}
