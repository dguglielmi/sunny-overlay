# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils multilib scons-utils toolchain-funcs

DESCRIPTION="A Qt based Digital DJ tool"
HOMEPAGE="http://www.mixxx.org/"
SRC_URI="https://github.com/mixxxdj/${PN}/archive/release-${PV/_/-}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="aac debug doc ffmpeg hid mp3 mp4 pulseaudio +qt4 qt5 shout wavpack"
REQUIRED_USE="^^ ( qt4 qt5 )"

RDEPEND="dev-libs/protobuf
	media-libs/chromaprint
	media-libs/flac
	media-libs/libid3tag
	media-libs/libogg
	media-libs/libsndfile
	>=media-libs/libsoundtouch-1.5
	media-libs/libvorbis
	>=media-libs/portaudio-19_pre
	media-libs/portmidi
	media-libs/rubberband
	>=media-libs/taglib-1.10
	media-libs/vamp-plugin-sdk
	sci-libs/fftw:3.0
	virtual/glu
	virtual/opengl
	qt4? (
		dev-qt/qtgui:4
		dev-qt/qtopengl:4
		dev-qt/qtsql:4
		dev-qt/qtsvg:4
		dev-qt/qttest:4
		dev-qt/qtwebkit:4
		dev-qt/qtxmlpatterns:4
	)
	qt5? (
		>=dev-qt/qtscript-5.4.2:5[scripttools]
		>=dev-qt/qtsvg-5.4.2:5
		>=dev-qt/qtsql-5.4.2:5
		>=dev-qt/qtxml-5.4.2:5
		>=dev-qt/qtopengl-5.4.2:5
		>=dev-qt/qtgui-5.4.2:5
		>=dev-qt/qtnetwork-5.4.2:5
		>=dev-qt/qtcore-5.4.2:5
		>=dev-qt/qtwidgets-5.4.2:5
		>=dev-qt/qttest-5.4.2:5
		>=dev-qt/qtxmlpatterns-5.4.2:5
		>=dev-qt/qtconcurrent-5.4.2:5
	)
	aac? (
		media-libs/faad2
		media-libs/libmp4v2:0
	)
	hid? ( dev-libs/hidapi )
	mp3? ( media-libs/libmad )
	mp4? ( media-libs/libmp4v2:= )
	ffmpeg? ( virtual/ffmpeg )
	pulseaudio? ( media-sound/pulseaudio )
	shout? ( media-libs/libshout )
	wavpack? ( media-sound/wavpack )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/${PN}-release-${PV/_/-}"

pkg_pretend() {
	if use ffmpeg; then
		ewarn "You enabled USE flag 'ffmpeg'. This is an experimental feature and suffers"
		ewarn "seek and performance issues."
		ewarn ""
	fi
	if use qt5; then
		ewarn "You enabled USE flag 'qt5'. This is an experimental feature and not"
		ewarn "recommended by upstream."
		ewarn ""
	fi
	ewarn "It is recommended by upstream to build libsoundtouch with SSE and CXXFLAGS=\"-ffast-math\"."
	ewarn "To enable this, please add this line to /etc/portage/env/media-libs/libsoundtouch:"
	ewarn "CXXFLAGS=\"\${CXXFLAGS} -ffast-math\""
	ewarn "Please note that \"-ffast-math\" breaks IEEE compliance and may change floating point results."
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-system-libs.patch
	epatch "${FILESDIR}"/${P}-docs.patch

	# use multilib compatible directory for plugins
	sed -i -e "/unix_lib_path =/s/'lib'/'$(get_libdir)'/" src/SConscript || die
}

src_configure() {
	if use qt5 ; then
		QTDIR=${EPREFIX}/usr/$(get_libdir)/qt5
	else
		QTDIR=${EPREFIX}/usr/$(get_libdir)/qt4
	fi

	myesconsargs=(
		prefix="${EPREFIX}/usr"
		qtdir="${QTDIR}"
		hifieq=1
		vinylcontrol=1
		optimize=0
		$(use_scons qt5)
		$(use_scons aac faad)
		$(use_scons debug qdebug)
		$(use_scons hid hid)
		$(use_scons mp3 mad)
		$(use_scons mp4 m4a)
		$(use_scons ffmpeg)
		$(use_scons shout shoutcast)
		$(use_scons wavpack wv)
	)
}

src_compile() {
	CC="$(tc-getCC)" CXX="$(tc-getCXX)" LINKFLAGS="${LDFLAGS}" \
	LIBPATH="${EPREFIX}/usr/$(get_libdir)" escons
}

src_install() {
	CC="$(tc-getCC)" CXX="$(tc-getCXX)" LINKFLAGS="${LDFLAGS}" \
	LIBPATH="${EPREFIX}/usr/$(get_libdir)" escons install \
		install_root="${ED}"/usr

	dodoc README Mixxx-Manual.pdf
}
