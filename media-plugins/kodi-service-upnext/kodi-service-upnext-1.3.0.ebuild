# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KODI_ADDON_TAG="6055716267b1780f648df78c78a576d9174bfd9b"
KODI_ADDON_ID="service.upnext"

DESCRIPTION="Proposes to play the next episode automatically for Kodi"
HOMEPAGE="https://github.com/im85288/service.upnext"

SRC_URI="
	https://github.com/im85288/${KODI_ADDON_ID}/archive/${KODI_ADDON_TAG}.tar.gz
		-> ${P}.tar.gz
"
S="${WORKDIR}/${KODI_ADDON_ID}-${KODI_ADDON_TAG}"

LICENSE="GPL-3+"
SLOT="0"

KEYWORDS="~amd64 ~x86"

DEPEND="media-tv/kodi"

src_prepare() {
	default
	sed -i -e '/addon="xbmc.python"/s#2\.25\.0#3.0.0#g' \
		-e '/addon id="service.upnext"/s#1\.1\.9#1.1.9+omega.1#g' \
		"${S}"/addon.xml
}

src_install() {
	insinto "/usr/share/kodi/addons/${KODI_ADDON_ID}"
	doins addon.xml LICENSE README.md
	doins -r "${S}"/resources
}
