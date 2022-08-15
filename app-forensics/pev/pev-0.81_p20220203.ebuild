# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PEV_COMMIT="2d6337beb6fa8be83d9164b45b53fd3b3300fb34"
LIBPE_COMMIT="5f44724e8fcdebf8a6b9fd009543c9dcfae4ea32"

DESCRIPTION="Multiplatform command line toolkit to work with PE binaries"
HOMEPAGE="https://github.com/merces/pev"
SRC_URI="https://github.com/merces/pev/archive/${PEV_COMMIT}.tar.gz -> ${P}.tar.gz
	https://github.com/merces/libpe/archive/${LIBPE_COMMIT}.tar.gz -> libpe-0_p20210819.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-fix-manpages-compression.patch" )

S="${WORKDIR}/${PN}-${PEV_COMMIT}"

src_prepare() {
	rmdir lib/libpe || die "Unable to remove libpe directory"
	ln -s ../../libpe-${LIBPE_COMMIT} lib/libpe || die "Unable to symlink libpe directory"

	sed -i \
		-e '/^prefix/s#\([^=]*\).*$#\1= '"${EPREFIX}/usr"'#' \
		-e '/^libdir/s#\([^=]*\).*$#\1= /usr/'$(get_libdir)'#' \
		src/Makefile lib/libpe/Makefile || die

	default
}
