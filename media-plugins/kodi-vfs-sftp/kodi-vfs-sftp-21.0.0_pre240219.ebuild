# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit kodi-addon

COMMIT_ID="9fe870e71a10a37f2d793b2261bac48b195f2705"

DESCRIPTION="SFTP VFS addon for Kodi"
HOMEPAGE="https://github.com/xbmc/vfs.sftp"

CODENAME="Omega"
KEYWORDS="~amd64 ~x86"
SRC_URI="https://github.com/xbmc/vfs.sftp/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/vfs.sftp-${COMMIT_ID}"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="
	net-libs/libssh[sftp]
	=media-tv/kodi-21*
	"
RDEPEND="${DEPEND}"

src_prepare() {
	[ -d depends ] && rm -rf depends || die
	cmake_src_prepare
}
