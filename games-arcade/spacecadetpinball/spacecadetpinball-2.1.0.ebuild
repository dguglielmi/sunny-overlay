# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg-utils

MY_PN="SpaceCadetPinball"

DESCRIPTION="Reverse engineering of 3D Pinball Space Cadet"
HOMEPAGE="https://github.com/k4zmu2a/SpaceCadetPinball"
SRC_URI="https://github.com/k4zmu2a/${MY_PN}/archive/refs/tags/Release_${PV}.tar.gz -> ${P}.tar.gz
	https://davipinheiro.com/wp-content/uploads/2021/02/Full-Tilt-Pinball_Win_EN.zip"

S="${WORKDIR}/${MY_PN}-Release_${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	media-libs/libsdl2[haptic]
	media-libs/sdl2-mixer[wav,midi,fluidsynth]
	media-sound/fluid-soundfont
"
BDEPEND="
	${DEPEND}
	app-arch/unzip
"
RDEPEND="${DEPEND}"

src_install() {
	insopts -m 0644
	insinto /usr/share/SpaceCadetPinball/
	doins "${WORKDIR}"/FULLTILT/CADET/CADET.DAT

	insinto /usr/share/SpaceCadetPinball/SOUND
	for snd in "${WORKDIR}"/FULLTILT/CADET/SOUND/*
	do
		doins "${snd}"
	done

	cmake_src_install
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
