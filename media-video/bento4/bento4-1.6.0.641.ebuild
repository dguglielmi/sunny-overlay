# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="$(ver_cut 1-3)-$(ver_cut 4)"

inherit cmake

DESCRIPTION="Full-featured MP4 format, MPEG DASH, HLS, CMAF SDK and tools"
HOMEPAGE="
	https://www.bento4.com/
	https://github.com/axiomatic-systems/Bento4
"

SRC_URI="
	https://github.com/axiomatic-systems/Bento4/archive/refs/tags/v${MY_PV}.tar.gz
		-> ${P}.tar.gz
"
S="${WORKDIR}/${PN^}-${MY_PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="+apps"

src_prepare() {
	sed -i 's#ap4 STATIC#ap4 SHARED#g' CMakeLists.txt || die

	sed -e 's#@BENTO4_VERSION@#'${MY_PV}'#g' \
		-e 's#@LIBDIR@#'$(get_libdir)'#g' \
		-e 's#@EPREFIX@#'"${EPREFIX}"/usr'#g' \
		"${FILESDIR}"/bento4.pc.in > bento4.pc || die

	# Avoid conflicts with media-libs/libmp4v2[utils]
	for app in Mp4Info Mp4Extract; do
		mv Source/C++/Apps/${app}/${app}.cpp Source/C++/Apps/${app}/${app}-${PN}.cpp || die
		mv Source/C++/Apps/${app} Source/C++/Apps/${app}-${PN} || die
	done

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
	insinto /usr/$(get_libdir)/pkgconfig
	doins "${S}"/bento4.pc

	cmake_src_install
}
