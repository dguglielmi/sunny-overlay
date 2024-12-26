# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..13} )

inherit meson python-single-r1

DESCRIPTION="An open source camera stack and framework for Linux, Android, and ChromeOS"
HOMEPAGE="https://libcamera.org/"
SRC_URI="https://gitlab.freedesktop.org/camera/libcamera/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+app debug gstreamer python qt6 trace udev unwind v4l"
#IUSE=+" doc test"

DEPEND="
	dev-libs/libyaml:=
	|| (
		dev-libs/openssl
		net-libs/gnutls
	)
	app? (
		dev-libs/libevent:=
		x11-libs/libdrm:=
		media-libs/libjpeg-turbo:=
		media-libs/libsdl2
	)
	debug? ( dev-libs/elfutils:= )
	gstreamer? (
		media-libs/gstreamer:=
		media-libs/gst-plugins-base )
	qt6? (
		dev-qt/qtbase[gui,opengl,widgets]
		media-libs/tiff
	)
	python? (
		$(python_gen_cond_dep '
				dev-python/jinja2[${PYTHON_USEDEP}]
				dev-python/ply[${PYTHON_USEDEP}]
				dev-python/pyyaml[${PYTHON_USEDEP}]
				dev-python/pybind11[${PYTHON_USEDEP}]
			')
	)
	trace? ( dev-util/lttng-ust:= )
	udev? ( virtual/libudev )
	unwind? ( sys-libs/libunwind:= )
"
#BDPEND="
#	doc? (
#		app-text/doxygen[dot]
#		dev-python/sphinx
#		dev-texlive/texlive-latexextra
#	)
#"
RDEPEND="
	${DEPEND}
	python? ( ${PYTHON_DEPS} )
	trace? ( dev-util/lttng-tools )
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_prepare() {
	if use python; then
		sed -i -e \
			"/^destdir =/s#=.*#= '$(python_get_sitedir)/libcamera'#g" \
			src/py/libcamera/meson.build || die
	fi

	default
}

src_configure() {
	local emesonargs=(
		-Dandroid=disabled
		$(meson_feature app cam)
		# Building documentation is broken
		# $(meson_feature doc documentation)
		-Ddocumentation=disabled
		$(meson_feature gstreamer)
		$(meson_feature python pycamera)
		$(meson_feature qt6 qcam)
		$(meson_feature udev)
		# Depend on libyuv
		# $(meson_use test)
		-Dtest=false
		-Dpipelines=imx8-isi,ipu3,mali-c55,rkisp1,rpi/vc4,simple,uvcvideo,vimc
		-Dbuildtype=$(usex debug debug plain)
		$(meson_use v4l v4l2)
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	if use python; then
		python_optimize "${D}/$(python_get_sitedir)/libcamera"
	fi
}
