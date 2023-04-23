# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit kodi-addon

DESCRIPTION="Kodi's RTMP inputstream addon"
HOMEPAGE="https://github.com/xbmc/inputstream.rtmp"
KODI_PLUGIN_NAME="inputstream.rtmp"

CODENAME="Nexus"
KEYWORDS="~amd64 ~x86"
SRC_URI="https://github.com/xbmc/${KODI_PLUGIN_NAME}/archive/${PV}-${CODENAME}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${KODI_PLUGIN_NAME}-${PV}-${CODENAME}"
DEPEND="=media-tv/kodi-20*:="

LICENSE="GPL-2+"
SLOT="0"
IUSE=""

DEPEND+="
	media-video/rtmpdump[ssl]
	"

RDEPEND="${DEPEND}"

BDEPEND="virtual/pkgconfig"

src_prepare() {
	if [ -d depends ]; then rm -rf depends || die; fi

	cmake_src_prepare
}
