# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit kodi-addon

DESCRIPTION="Kodi's FFMpeg Direct Inputstream addon"
HOMEPAGE="https://github.com/xbmc/inputstream.ffmpegdirect"
SRC_URI=""

KEYWORDS="~amd64 ~arm ~arm64 ~x86"
CODENAME="Nexus"
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
	=media-tv/kodi-20*
	"

DEPEND="
	${COMMON_DEPEND}
	"

RDEPEND="
	${COMMON_DEPEND}
	"

PATCHES=(
	"${FILESDIR}"/${P}-ffmpeg5.patch
	"${FILESDIR}"/${P}-Get-extradata-with-extract_extradata-BSF.patch
	"${FILESDIR}"/${P}-Fix-use-after-free-in-TimeshiftSegment.patch
	"${FILESDIR}"/${P}-ffmpeg6.patch
	"${FILESDIR}"/${P}-gcc13.patch
)

src_prepare() {
	[ -d depends ] && rm -rf depends || die
	cmake_src_prepare
}
