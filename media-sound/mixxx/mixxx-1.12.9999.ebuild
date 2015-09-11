# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3 eutils multilib scons-utils toolchain-funcs

DESCRIPTION="A Qt based Digital DJ tool"
HOMEPAGE="http://www.mixxx.org/"
EGIT_REPO_URI="git://github.com/mixxxdj/${PN}.git"
EGIT_BRANCH="1.12"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="aac debug doc ffmpeg hid mp3 mp4 pulseaudio shout wavpack"

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
	media-libs/taglib
	media-libs/vamp-plugin-sdk
	sci-libs/fftw:3.0
	virtual/glu
	virtual/opengl
	dev-qt/qtgui:4
	dev-qt/qtopengl:4
	dev-qt/qtsql:4
	dev-qt/qtsvg:4
	dev-qt/qttest:4
	dev-qt/qtwebkit:4
	dev-qt/qtxmlpatterns:4
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

src_prepare() {
	epatch "${FILESDIR}"/${PN}-9999-system-libs.patch
	epatch "${FILESDIR}"/${PN}-9999-docs.patch
	epatch "${FILESDIR}"/${PN}-9999-desktop-file.patch

	# use multilib compatible directory for plugins
	sed -i -e "/unix_lib_path =/s/'lib'/'$(get_libdir)'/" src/SConscript || die

	# alter startup command when pulseaudio support is disabled
	if ! use pulseaudio ; then
		sed -i -e 's:pasuspender ::' res/linux/mixxx.desktop || die
	fi
}

src_configure() {
	myesconsargs=(
		prefix="${EPREFIX}/usr"
		qtdir="${EPREFIX}/usr/$(get_libdir)/qt4"
		hifieq=1
		vinylcontrol=1
		optimize=0
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
