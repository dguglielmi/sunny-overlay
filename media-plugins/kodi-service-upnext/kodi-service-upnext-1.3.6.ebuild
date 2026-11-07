# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KODI_ADDON_ID="service.upnext"

DESCRIPTION="Proposes to play the next episode automatically for Kodi"
HOMEPAGE="https://github.com/im85288/service.upnext"

SRC_URI="
	https://github.com/im85288/${KODI_ADDON_ID}/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.tar.gz
"
S="${WORKDIR}/${KODI_ADDON_ID}-${PV}"

LICENSE="GPL-3+"
SLOT="0"

KEYWORDS="~amd64 ~x86"

DEPEND="media-tv/kodi"

src_install() {
	insinto "/usr/share/kodi/addons/${KODI_ADDON_ID}"
	doins addon.xml LICENSE README.md
	doins -r "${S}"/resources
}
