# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="$(ver_rs 3 '-')"
BENTO4_COMMIT_ID="0010f4fd420ef7d6504d2e401a46c15f4ef3d3ca"

inherit cmake

DESCRIPTION="Full-featured MP4 format, MPEG DASH, HLS, CMAF SDK and tools"
HOMEPAGE="
	https://www.bento4.com/
	https://github.com/axiomatic-systems/Bento4
"

SRC_URI="
	https://github.com/axiomatic-systems/Bento4/archive/${BENTO4_COMMIT_ID}.tar.gz
		-> ${P}.tar.gz
"
S="${WORKDIR}/${PN^}-${BENTO4_COMMIT_ID}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="+apps"

src_prepare() {
	# Avoid conflicts with media-libs/libmp4v2[utils]
	for app in Mp4Info Mp4Extract; do
		mv Source/C++/Apps/${app}/${app}.cpp Source/C++/Apps/${app}/${app}-${PN}.cpp || die
		mv Source/C++/Apps/${app} Source/C++/Apps/${app}-${PN} || die
	done

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_APPS=$(usex apps ON OFF)
		-DBUILD_SHARED_LIBRARY=ON
		-DCMAKE_SKIP_BUILD_RPATH=ON
	)
	cmake_src_configure
}
