# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake kodi-addon

DESCRIPTION="SFTP VFS addon for Kodi"
HOMEPAGE="https://github.com/xbmc/vfs.sftp"
SRC_URI=""

CODENAME="Nexus"
KEYWORDS="~amd64 ~x86"
SRC_URI="https://github.com/xbmc/vfs.sftp/archive/${PV}-${CODENAME}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/vfs.sftp-${PV}-${CODENAME}"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="
	net-libs/libssh[sftp]
	=media-tv/kodi-20*
	"
RDEPEND="${DEPEND}"

src_prepare() {
	[ -d depends ] && rm -rf depends || die
	cmake_src_prepare
}
