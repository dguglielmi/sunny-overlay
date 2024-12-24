# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop toolchain-funcs xdg-utils

COMMIT_ID="99e59fdddbc3"

DESCRIPTION="The fast and accurate Genesis emulator"
HOMEPAGE="https://www.retrodev.com/blastem/"
SRC_URI="https://www.retrodev.com/repos/blastem/archive/${COMMIT_ID}.tar.bz2 -> ${P}.tar.bz2"

S="${WORKDIR}/${PN}-${COMMIT_ID}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="+opengl +system-zlib"

DEPEND="
	opengl? ( media-libs/glew )
	media-libs/libsdl2
	sys-libs/zlib
"
RDEPEND="${DEPEND}"

src_compile() {
	local myemakeargs=(
		CC="$(tc-getCC)"
		OPT="${CFLAGS} ${LDFLAGS}"
		CONFIG_PATH="/usr/share/games/${PN}"
		DATA_PATH="/usr/share/games/${PN}"
	)

	if ! use opengl; then
		myemakeargs+=("NOGL=1")
	fi

	if use system-zlib; then
		myemakeargs+=("HOST_ZLIB=1")
	fi

	emake "${myemakeargs[@]}"
}

src_install() {
	dobin blastem

	insinto "/usr/share/games/${PN}"
	doins -r shaders images default.cfg rom.db gamecontrollerdb.txt

	newicon "${S}/android/res/drawable-xxhdpi/ic_launcher.png" ${PN}.png
	make_desktop_entry "${PN}" 'BlastEm' "${PN}" 'Game;Emulator'
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
