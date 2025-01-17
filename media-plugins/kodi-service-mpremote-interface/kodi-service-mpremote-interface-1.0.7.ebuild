# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KODI_ADDON_TAG="f37a8392b7288a483757994602ac2c88ab3bf938"
KODI_ADDON_ID="service.mpremote.interface"

DESCRIPTION="Multimedia Player Remote Interfaces for Kodi"
HOMEPAGE="https://github.com/wastis/MediaPlayerRemoteInterface"

SRC_URI="
	https://github.com/wastis/MediaPlayerRemoteInterface/archive/${KODI_ADDON_TAG}.tar.gz
		-> ${P}.tar.gz
"
S="${WORKDIR}/MediaPlayerRemoteInterface-${KODI_ADDON_TAG}"

LICENSE="GPL-3+"
SLOT="0"

KEYWORDS="~amd64 ~x86"

RDEPEND="media-tv/kodi"
DEPEND="media-tv/kodi"

src_install() {
	insinto "/usr/share/kodi/addons/${KODI_ADDON_ID}"
	doins -r "${S}"/.
}
