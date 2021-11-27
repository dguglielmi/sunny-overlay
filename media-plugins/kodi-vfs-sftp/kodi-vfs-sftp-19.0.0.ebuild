# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake kodi-addon

CODENAME="Matrix"

DESCRIPTION="SFTP VFS addon for Kodi"
HOMEPAGE="https://github.com/xbmc/vfs.sftp"
SRC_URI="https://github.com/xbmc/vfs.sftp/archive/${PV}-${CODENAME}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND="
	net-libs/libssh[sftp]
	=media-tv/kodi-19*
	"
RDEPEND="${DEPEND}"

S="${WORKDIR}/vfs.sftp-${PV}-${CODENAME}"

src_prepare() {
	[ -d depends ] && rm -rf depends || die
	cmake_src_prepare
}
