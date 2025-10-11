# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT_ID="09ccd020d5d1aa34b91e9f30b01a4166dd31f51b"

DESCRIPTION="Intel IPU7 MIPI camera proprietary image processing libraries"
HOMEPAGE="https://github.com/intel/ipu7-camera-bins"

SRC_URI="https://github.com/intel/${PN}/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT_ID}"

LICENSE="INTEL-IPU"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="elibc_musl"

src_prepare() {
	sed -i \
		-e '/^libdir=/s#.*#libdir=${prefix}/'$(get_libdir)'#g' \
		lib/pkgconfig/*.pc || die

	default
}

src_install() {
	dolib.so lib/libia_*

	insinto /usr/$(get_libdir)/pkgconfig
	doins lib/pkgconfig/ia_imaging-ipu7*.pc

	insinto /usr/include/ipu7x/ia_imaging
	doins include/ipu7x/ia_imaging/*.h

	insinto /usr/include/ipu75xa/ia_imaging
	doins include/ipu75xa/ia_imaging/*.h
}
