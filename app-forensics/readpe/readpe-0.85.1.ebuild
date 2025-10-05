# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Multiplatform command line toolkit to work with PE binaries"
HOMEPAGE="https://github.com/mentebinaria/readpe"
SRC_URI="
	https://github.com/mentebinaria/readpe/archive/v${PV}.tar.gz
	-> ${P}.tar.gz
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-fix-manpages-compression.patch" )

src_prepare() {
	sed -i \
		-e '/^prefix/s#\([^=]*\).*$#\1= '"${EPREFIX}/usr"'#' \
		-e '/^libdir/s#\([^=]*\).*$#\1= /usr/'$(get_libdir)'#' \
		src/Makefile lib/libpe/Makefile || die

	default
}

src_compile() {
	emake CC="$(tc-getCC)"
}
