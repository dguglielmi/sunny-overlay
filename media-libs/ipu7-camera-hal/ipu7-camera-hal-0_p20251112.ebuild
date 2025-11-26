# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake udev

COMMIT_ID="affeb2200bfa61f98ef4be08ff046767d40fcedf"

DESCRIPTION="Intel IPU7 MIPI camera HAL"
HOMEPAGE="https://github.com/intel/ipu7-camera-hal"

SRC_URI="https://github.com/intel/${PN}/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT_ID}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/expat
	dev-libs/jsoncpp
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	media-libs/ipu7-camera-bins
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	sed -i \
		-e '/cmake_minimum_required/s#2\.8#3.5#1' \
		CMakeLists.txt || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_CAMHAL_ADAPTOR=ON
		-DBUILD_CAMHAL_PLUGIN=ON
		-DIPU_VERSIONS="ipu7x;ipu75xa"
		-DUSE_PG_LITE_PIPE=ON
		-DUSE_STATIC_GRAPH=ON
		-DUSE_STATIC_GRAPH_AUTOGEN=ON
	)
	cmake_src_configure
}

src_install() {
	udev_dorules "${FILESDIR}"/72-intel-mipi-ipu7-camera.rules
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
