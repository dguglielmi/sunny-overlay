# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

MY_PN="${PN%-ttf}"

DESCRIPTION="Twitter Emoji for everyone"
HOMEPAGE="https://github.com/jdecked/twemoji/"
SRC_URI="https://distfiles.alpinelinux.org/distfiles/edge/${MY_PN^}-${PV}.ttf"

S="${WORKDIR}"

LICENSE="MIT CC-BY-4.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

FONT_CONF=( "${FILESDIR}/75-${MY_PN}.conf" )
FONT_SUFFIX="ttf"

src_unpack() {
	cp "${DISTDIR}/${A}" "${S}/${MY_PN^}.${FONT_SUFFIX}" || die
}
