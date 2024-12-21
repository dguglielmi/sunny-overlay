# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..13} )

inherit meson python-single-r1

COMMIT_ID="e37830925130afd541449ed22df0bc952c19a94a"

DESCRIPTION="An open source camera stack and framework for Linux, Android, and ChromeOS"
HOMEPAGE="https://libcamera.org/"
SRC_URI="
	https://gitlab.freedesktop.org/camera/libcamera/-/archive/${COMMIT_ID}.tar.bz2
		-> ${P}.tar.bz2
"
S="${WORKDIR}/${PN}-${COMMIT_ID}"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+app debug doc gstreamer python qt6 test udev"

DEPEND="
	$(python_gen_cond_dep '
			dev-python/pyyaml[${PYTHON_USEDEP}]
			dev-python/pybind11[${PYTHON_USEDEP}]
		')
	app? (
		dev-libs/libevent
		media-libs/libsdl2
		media-libs/libjpeg-turbo
		x11-libs/libdrm
	)
	doc? (
		app-text/doxygen
		dev-python/sphinx
		dev-texlive/texlive-latexextra
		media-gfx/graphviz
	)
	gstreamer? ( media-libs/gst-plugins-base )
	qt6? (
		dev-qt/qtbase[gui,opengl,widgets]
		media-libs/tiff
	)
	udev? ( virtual/libudev )
"
BDEPEND="dev-libs/openssl"
RDEPEND="
	${DEPEND}
	${PYTHON_DEPS}
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"

src_prepare() {
	if use python; then
		sed -i -e "/destdir =/s#destdir =.*#destdir = '"$(python_get_sitedir)"/libcamera'#g" \
			src/py/libcamera/meson.build || die
	fi

	default
}

src_configure() {
	local emesonargs=(
		-Dandroid=disabled
		$(meson_feature app cam)
		$(meson_feature doc documentation)
		$(meson_feature gstreamer)
		$(meson_feature python pycamera)
		$(meson_feature qt6 qcam)
		$(meson_feature udev)
		$(meson_use test)
		-Dbuildtype=$(usex debug debug plain)
		-Dv4l2=true
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	python_optimize "${D}/$(python_get_sitedir)/libcamera"
}
