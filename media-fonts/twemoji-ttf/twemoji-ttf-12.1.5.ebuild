# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

MY_PN="${PN%-ttf}"

DESCRIPTION="Twitter Emoji for everyone"
HOMEPAGE="https://twemoji.twitter.com/"
SRC_URI="https://kojipkgs.fedoraproject.org/packages/twitter-${MY_PN}-fonts/${PV}/3.fc32/noarch/twitter-${MY_PN}-fonts-${PV}-3.fc32.noarch.rpm"

LICENSE="MIT CC-BY-4.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
BDEPEND="app-arch/libarchive[zstd]"

S="${WORKDIR}/usr/share/fonts/${MY_PN}"
FONT_S="${S}"
FONT_CONF=( "${FILESDIR}/75-${MY_PN}.conf" )
FONT_SUFFIX="ttf"

src_unpack() {
	bsdtar xf "${DISTDIR}/${A}" || die
}
