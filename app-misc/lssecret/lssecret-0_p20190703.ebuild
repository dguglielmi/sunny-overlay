# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="lssecrets lists all secret items in a secret service using libsecret"
HOMEPAGE="https://gitlab.com/GrantMoyer/lssecret"
SRC_URI="https://gitlab.com/GrantMoyer/lssecret/-/raw/722013dc982e56f8127d3ab0105606410d4e1744/lssecret.cpp?inline=false -> ${P}.cpp"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-crypt/libsecret"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

S=${WORKDIR}

src_unpack() {
	cp "${DISTDIR}/${P}.cpp" lssecret.cpp || die
}

src_compile() {
	$(tc-getCXX) lssecret.cpp ${CXXFLAGS} $(pkg-config --cflags --libs libsecret-1) -o lssecret || die
}

src_install() {
	dobin lssecret || die
}
