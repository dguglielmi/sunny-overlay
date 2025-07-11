# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg udev

MY_PV=$(ver_cut 1-2)
DESCRIPTION="Advanced Digital DJ tool based on Qt"
HOMEPAGE="https://mixxx.org/"
SRC_URI="https://github.com/mixxxdj/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

IUSE="aac ffmpeg hid keyfinder lv2 modplug mp3 mp4 opengl opus qt5 +qt6 qtkeychain shout wavpack"

RDEPEND="
	dev-cpp/benchmark
	dev-cpp/gtest
	dev-cpp/ms-gsl
	dev-db/sqlite
	dev-libs/glib:2
	dev-libs/protobuf:=
	media-libs/chromaprint
	~media-libs/libdjinterop-0.24.3
	media-libs/flac:=
	media-libs/libebur128
	media-libs/libid3tag:=
	media-libs/libogg
	media-libs/libsndfile
	media-libs/libsoundtouch
	media-libs/libvorbis
	media-libs/portaudio[alsa]
	media-libs/portmidi
	media-libs/rubberband:=
	media-libs/taglib:=
	media-libs/vamp-plugin-sdk
	media-sound/lame
	sci-libs/fftw:3.0=
	sys-power/upower
	virtual/glu
	virtual/libusb:1
	virtual/opengl
	virtual/udev
	x11-libs/libX11
	aac? (
		media-libs/faad2
		media-libs/libmp4v2
	)
	ffmpeg? ( media-video/ffmpeg:= )
	hid? ( dev-libs/hidapi )
	keyfinder? ( media-libs/libkeyfinder )
	lv2? ( media-libs/lilv )
	modplug? ( media-libs/libmodplug )
	mp3? ( media-libs/libmad )
	mp4? ( media-libs/libmp4v2:= )
	opus? (	media-libs/opusfile )
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtdeclarative:5
		dev-qt/qtdbus:5
		dev-qt/qtgui:5
		dev-qt/qtnetwork:5
		dev-qt/qtopengl:5
		dev-qt/qtprintsupport
		dev-qt/qtscript:5[scripttools]
		dev-qt/qtsql:5
		dev-qt/qtsvg:5
		dev-qt/qtwidgets:5
		dev-qt/qtx11extras:5
		dev-qt/qtxml:5
	)
	qt6? (
		dev-qt/qtbase[concurrent,cups,dbus,gui,network,opengl,sql,widgets,xml]
		dev-qt/qtdeclarative:6
		dev-qt/qt5compat:6
		dev-qt/qtshadertools:6
		dev-qt/qtsvg:6
	)
	qtkeychain? ( dev-libs/qtkeychain:=[qt5(+),qt6?] )
	wavpack? ( media-sound/wavpack )
"
	# libshout-idjc-2.4.6 is required. Please check and re-add once it's
	# available in ::gentoo
	# Meanwhile we're using the bundled libshout-idjc. See bug #775443
	#shout? ( >=media-libs/libshout-idjc-2.4.6 )

DEPEND="${RDEPEND}
	qt5? ( dev-qt/qtconcurrent:5 )

"
BDEPEND="
	qt5? (
		dev-qt/qttest:5
		dev-qt/qtxmlpatterns:5
	)
	virtual/pkgconfig
"

PLOCALES="
	ca cs de en es fi fr gl id it ja nl pl pt ro ru sl sq sr tr zh-CN zh-TW
"

REQUIRED_USE="^^ ( qt5 qt6 )"

mixxx_set_globals() {
	local lang
	local MANUAL_URI_BASE="https://downloads.mixxx.org/manual/${MY_PV}"
	for lang in ${PLOCALES} ; do
		SRC_URI+=" l10n_${lang}? ( ${MANUAL_URI_BASE}/${PN}-manual-${MY_PV}-${lang/-/_}.pdf )"
		IUSE+=" l10n_${lang/ en/ +en}"
	done
	SRC_URI+=" ${MANUAL_URI_BASE}/${PN}-manual-${MY_PV}-en.pdf"
}
mixxx_set_globals

src_configure() {
	local mycmakeargs=(
		-DBATTERY="on"
		-DBROADCAST="$(usex shout on off)"
		-DCCACHE_SUPPORT="off"
		-DFAAD="$(usex aac on off)"
		-DFFMPEG="$(usex ffmpeg on off)"
		-DHID="$(usex hid on off)"
		-DINSTALL_USER_UDEV_RULES=OFF
		-DKEYFINDER="$(usex keyfinder on off)"
		-DLILV="$(usex lv2 on off)"
		-DMAD="$(usex mp3 on off)"
		-DMODPLUG="$(usex modplug on off)"
		-DOPTIMIZE="off"
		-DQOPENGL="$(usex opengl on off)"
		-DOPUS="$(usex opus on off)"
		# Experimental for 2.5 (check for 2.6)
		-DQML="off"
		-DQT6="$(usex qt6 on off)"
		-DQTKEYCHAIN="$(usex qtkeychain on off)"
		-DVINYLCONTROL="on"
		-DWAVPACK="$(usex wavpack on off)"
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install
	udev_newrules "${S}"/res/linux/mixxx-usb-uaccess.rules 69-mixxx-usb-uaccess.rules
	dodoc README.md CHANGELOG.md
	local locale
	for locale in ${PLOCALES} ; do
		if use l10n_${locale} ; then
			dodoc "${DISTDIR}"/${PN}-manual-${MY_PV}-${locale/-/_}.pdf
		fi
	done
}

pkg_postinst() {
	xdg_pkg_postinst
	udev_reload
}

pkg_postrm() {
	xdg_pkg_postrm
	udev_reload
}
