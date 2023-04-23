# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Bento4 tools designed to read and write ISO-MP4 files"
HOMEPAGE="
	https://www.bento4.com/
	https://github.com/axiomatic-systems/Bento4
"

IUSE="+apps"

MY_PV="$(ver_cut 1-3)-$(ver_cut 4)"

SRC_URI="https://github.com/axiomatic-systems/Bento4/archive/refs/tags/v${MY_PV}tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

S="${WORKDIR}/${PN^}-${MY_PV}"

src_prepare() {
	sed -i 's#ap4 STATIC#ap4 SHARED#g' CMakeLists.txt
	sed -e 's#@BENTO4_VERSION@#'${MY_PV}'#g' "${FILESDIR}"/bento4.pc.in > bento4.pc
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_SKIP_BUILD_RPATH=ON
		-DBUILD_APPS=$(usex apps ON OFF)
	)
	cmake_src_configure
}

src_install() {
	cd "${BUILD_DIR}" || die

	# Avoid conflicts with media-libs/libmp4v2[utils]
	mv mp4extract mp4extract-bento4 || die
	mv mp4info mp4info-bento4 || die

	if use apps; then
		dobin aac2mp4 avcinfo fixaacsampledescription hevcinfo mp42aac mp42avc \
			mp42hevc mp42hls mp42ts mp4audioclip mp4compact mp4dcfpackager \
			mp4decrypt mp4diff mp4dump mp4edit mp4encrypt mp4extract-bento4 \
			mp4fragment mp4iframeindex mp4info-bento4 mp4mux mp4pssh mp4rtphintinfo \
			mp4split mp4tag
	fi

	dolib.so libap4.so

	insinto "${EPREFIX}"/usr/include/bento4
	doins ${S}/Source/C++/*/*.h

	insinto "${EPREFIX}"/usr/$(get_libdir)/pkgconfig
	doins ${S}/bento4.pc

	dodoc ${S}/Documents/LICENSE.txt
}
