# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit flag-o-matic scons-utils toolchain-funcs

DESCRIPTION="Advanced Digital DJ tool based on Qt"
HOMEPAGE="https://www.mixxx.org/"
SRC_URI="https://github.com/mixxxdj/${PN}/archive/release-${PV}.tar.gz -> ${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="aac doc ffmpeg hid mp3 mp4 shout wavpack"

RDEPEND="
	dev-db/sqlite
	dev-libs/protobuf:0=
	dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtopengl:5
	dev-qt/qtscript:5[scripttools]
	dev-qt/qtsql:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
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
	sci-libs/fftw:3.0=
	virtual/libusb:1
	virtual/opengl
	x11-libs/libX11
	aac? (
		media-libs/faad2
		media-libs/libmp4v2:0
	)
	hid? ( dev-libs/hidapi )
	mp3? ( media-libs/libmad )
	mp4? ( media-libs/libmp4v2:= )
	shout? ( media-libs/libshout )
	wavpack? ( media-sound/wavpack )
	ffmpeg? ( media-video/ffmpeg:0= )
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
	dev-qt/qttest:5
	dev-qt/qtxmlpatterns:5
"

PATCHES=(
	"${FILESDIR}"/${PN}-2.0.0-docs.patch
	"${FILESDIR}"/${P}-swap-default-values-for-temp-perm-ratechanges.patch
	"${FILESDIR}"/${P}-fix-invocation-args-of-pasuspender.patch
	"${FILESDIR}"/${P}-fix-unresponsive-scrolling-through-crates-and-playlists-using-encoder.patch
	"${FILESDIR}"/${P}-debug-assert-and-fix-false-poisitiv-restart-request.patch
	"${FILESDIR}"/${P}-fidlib-thread-safe-and-reentrant-generation-of-filters.patch
	"${FILESDIR}"/${P}-fix-navigation-usability-issues-in-sidebar-tree.patch
	"${FILESDIR}"/${P}-fix-latenight-group-fx-buttons-in-deck.patch
	"${FILESDIR}"/${P}-fix-crash-when-removing-a-quick-link.patch
	"${FILESDIR}"/${P}-fix-clearing-of-replaygain-gain-ratio-in-file-tags.patch
	"${FILESDIR}"/${P}-fix-memory-leak-when-loading-cover-art.patch
	"${FILESDIR}"/${P}-use-an-in-memory-database-to-speed-up-library-tests.patch
	"${FILESDIR}"/${P}-fix-integration-of-external-track-libraries.patch
	"${FILESDIR}"/${P}-fix-flac-decoding-and-upgrade-db-schema.patch
	"${FILESDIR}"/${P}-fix-s4-mk2-for-windows.patch
	"${FILESDIR}"/${P}-pioneer-ddj-sx-mapping-bugfixes.patch
	"${FILESDIR}"/${P}-fix-spinback-inertia-effect-partial-revert-of-2b612c2.patch
	"${FILESDIR}"/${P}-denon-mc6000mk2-use-ramping-for-back-spins.patch
	"${FILESDIR}"/${P}-deere-add-gain-knob-to-expanded-sampler-view.patch
)

S="${WORKDIR}/${PN}-release-${PV}"

src_prepare() {
	# use multilib compatible directory for plugins
	sed -i -e "/unix_lib_path =/s/'lib'/'$(get_libdir)'/" src/SConscript || die

	default
}

src_configure() {
	local myoptimize=0

	# Required for >=qt-5.7.0 (bug #590690)
	append-cxxflags -std=c++11

	# Try to get cpu type based on CFLAGS.
	# Bug #591968
	for i in $(get-flag mcpu) $(get-flag march) ; do
		if [[ ${i} = native ]] ; then
			myoptimize="native"
			break
		fi
	done

	myesconsargs=(
		prefix="${EPREFIX}/usr"
		qtdir="${EPREFIX}/usr/$(get_libdir)/qt5"
		faad="$(usex aac 1 0)"
		ffmpeg="$(usex ffmpeg 1 0)"
		hid="$(usex hid 1 0)"
		hifieq=1
		m4a="$(usex mp4 1 0)"
		mad="$(usex mp3 1 0)"
		optimize="${myoptimize}"
		# force qdebug enabled (https://bugs.launchpad.net/mixxx/+bug/1737546)
		qdebug=1
		qt5=1
		shoutcast="$(usex shout 1 0)"
		vinylcontrol=1
		wv="$(usex wavpack 1 0)"
	)
}

src_compile() {
	CC="$(tc-getCC)" CXX="$(tc-getCXX)" LINKFLAGS="${LDFLAGS}" \
	LIBDIR="${EPREFIX}/usr/$(get_libdir)" escons ${myesconsargs[@]}
}

src_install() {
	CC="$(tc-getCC)" CXX="$(tc-getCXX)" LINKFLAGS="${LDFLAGS}" \
	LIBDIR="${EPREFIX}/usr/$(get_libdir)" escons ${myesconsargs[@]} \
		install_root="${ED}"/usr install

	dodoc README Mixxx-Manual.pdf
}
