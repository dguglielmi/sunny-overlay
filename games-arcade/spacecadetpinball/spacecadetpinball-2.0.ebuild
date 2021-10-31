# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop

MY_PN="SpaceCadetPinball"

DESCRIPTION="Reverse engineering of 3D Pinball Space Cadet"
HOMEPAGE="https://github.com/k4zmu2a/SpaceCadetPinball"
SRC_URI="https://github.com/k4zmu2a/${MY_PN}/archive/refs/tags/Release_${PV}.tar.gz -> ${P}.tar.gz
	https://davipinheiro.com/wp-content/uploads/2021/02/Full-Tilt-Pinball_Win_EN.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="media-libs/libsdl2[haptic]
	media-libs/sdl2-mixer[wav,midi,timidity]"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${MY_PN}-Release_${PV}"

PATCHES="${FILESDIR}/${PN}-basepath.patch"

src_install() {
	dobin ${S}/bin/${MY_PN} || die
	doicon ${FILESDIR}/${MY_PN}.png
	make_desktop_entry ${MY_PN} '3D Pinball Space Cadet' ${MY_PN} "Game;ArcadeGame"

	insopts -m 0644
	insinto /usr/share/spacecadetpinball
	doins ${WORKDIR}/FULLTILT/CADET/CADET.DAT

	insinto /usr/share/spacecadetpinball/SOUND
	for snd in ${WORKDIR}/FULLTILT/CADET/SOUND/*
	do
		doins "${snd}"
	done
}
