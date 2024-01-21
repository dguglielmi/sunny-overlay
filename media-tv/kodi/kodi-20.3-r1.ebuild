# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# FFmpeg can be unbundled, but is currently stuck at a very old version.
# libdvd{css,read,nav} are not unbundlable without patching the buildsystem.

# Versions for the forked projects that are bundled
# See tools/depends/target/<project>/<project>-VERSION
LIBDVDCSS_VERSION="1.4.3-Next-Nexus-Alpha2-2"
LIBDVDREAD_VERSION="6.1.3-Next-Nexus-Alpha2-2"
LIBDVDNAV_VERSION="6.1.1-Next-Nexus-Alpha2-2"
FFMPEG_VERSION="4.4.1"
CODENAME="Nexus"
FFMPEG_KODI_VERSION="Alpha1"

# Doesn't build with jdk-21
_JAVA_PKG_WANT_BUILD_VM=( {openjdk{,-jre},icedtea}{,-bin}-{8,11,17} )
JAVA_PKG_WANT_BUILD_VM=${_JAVA_PKG_WANT_BUILD_VM[@]}
# Required to be set, but not used.
JAVA_PKG_WANT_SOURCE="17"
JAVA_PKG_WANT_TARGET="17"

PYTHON_REQ_USE="sqlite,ssl"
PYTHON_COMPAT=( python3_{10..11} ) # python3.12 support added in 21

CPU_FLAGS="cpu_flags_x86_sse cpu_flags_x86_sse2 cpu_flags_x86_sse3 cpu_flags_x86_sse4_1 cpu_flags_x86_sse4_2 cpu_flags_x86_avx cpu_flags_x86_avx2 cpu_flags_arm_neon"

inherit cmake desktop flag-o-matic java-pkg-2 linux-info optfeature pax-utils python-single-r1 xdg

DESCRIPTION="A free and open source media-player and entertainment hub"
HOMEPAGE="https://kodi.tv/"

SRC_URI="
	https://github.com/xbmc/libdvdnav/archive/${LIBDVDNAV_VERSION}.tar.gz
		-> libdvdnav-${LIBDVDNAV_VERSION}.tar.gz
	https://github.com/xbmc/libdvdread/archive/${LIBDVDREAD_VERSION}.tar.gz
		-> libdvdread-${LIBDVDREAD_VERSION}.tar.gz
	css? (
		https://github.com/xbmc/libdvdcss/archive/${LIBDVDCSS_VERSION}.tar.gz
			-> libdvdcss-${LIBDVDCSS_VERSION}.tar.gz
	)
	!system-ffmpeg? (
		https://github.com/xbmc/FFmpeg/archive/${FFMPEG_VERSION}-${CODENAME}-${FFMPEG_KODI_VERSION}.tar.gz
			-> ffmpeg-${PN}-${FFMPEG_VERSION}-${CODENAME}-${FFMPEG_KODI_VERSION}.tar.gz
	)
"
if [[ ${PV} == *9999 ]] ; then
	EGIT_REPO_URI="https://github.com/xbmc/xbmc.git"
	if [[ ${PV} != "9999" ]]; then
		EGIT_BRANCH="${CODENAME}"
	fi
	inherit git-r3
else
	MY_PV=${PV/_p/_r}
	MY_PV=${MY_PV/_alpha/a}
	MY_PV=${MY_PV/_beta/b}
	MY_PV=${MY_PV/_rc/RC}
	MY_PV="${MY_PV}-${CODENAME}"
	MY_P="${PN}-${MY_PV}"
	SRC_URI+=" https://github.com/xbmc/xbmc/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	S=${WORKDIR}/xbmc-${MY_PV}
fi

LICENSE="GPL-2+"
SLOT="0"
# use flag is called libusb so that it doesn't fool people in thinking that
# it is _required_ for USB support. Otherwise they'll disable udev and
# that's going to be worse.
IUSE="airplay alsa bluetooth bluray caps cec +css dbus doc eventclients gbm gles lcms libusb lirc mariadb mysql nfs +optical pipewire pulseaudio raspberry-pi samba system-ffmpeg test udf udev upnp vaapi vdpau wayland webserver X +xslt zeroconf ${CPU_FLAGS}"
REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	^^ ( gbm wayland X )
	?? ( mariadb mysql )
	bluray? ( udf )
	gbm? ( udev )
	udev? ( !libusb )
	vdpau? ( X !gles !gbm )
	zeroconf? ( dbus )
"
RESTRICT="!test? ( test )"

# dev-libs/libcec[-cubox] bug #818262
COMMON_DEPEND="
	>=dev-libs/flatbuffers-1.12.0:=
	>=dev-libs/lzo-2.04:2
	media-libs/giflib:=
	>=media-libs/libjpeg-turbo-2.0.4:=
	>=media-libs/libpng-1.6.26:0=
	wayland? (
		dev-cpp/waylandpp:=
	)
"
COMMON_TARGET_DEPEND="${PYTHON_DEPS}
	>=net-misc/curl-7.68.0[http2]
	>=sys-libs/zlib-1.2.11
	dev-db/sqlite:3
	dev-libs/crossguid
	>=dev-libs/fribidi-1.0.5
	>=dev-libs/libcdio-2.1.0:=[cxx]
	>=dev-libs/libfmt-6.1.2:=
	dev-libs/libfstrcmp
	dev-libs/libpcre[cxx]
	>=dev-libs/openssl-1.1.1k:0=
	>=dev-libs/spdlog-1.5.0:=
	dev-libs/tinyxml[stl]
	media-fonts/roboto
	media-libs/libglvnd[X?]
	>=media-libs/freetype-2.10.1
	media-libs/harfbuzz:=
	>=media-libs/libass-0.13.4:=
	media-libs/mesa[egl(+),gbm(+)?,wayland?,X?]
	>=media-libs/taglib-1.9.0
	sci-libs/kissfft
	virtual/libiconv
	virtual/ttf-fonts
	x11-libs/libdrm
	$(python_gen_cond_dep '
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/pycryptodome[${PYTHON_USEDEP}]
	')
	airplay? (
		>=app-pda/libplist-2.0.0:=
		net-libs/shairplay
	)
	alsa? (
		>=media-libs/alsa-lib-1.1.4.1
	)
	bluetooth? (
		net-wireless/bluez:=
	)
	bluray? (
		>=media-libs/libbluray-1.1.2:=
	)
	caps? (
		sys-libs/libcap
	)
	cec? (
		>=dev-libs/libcec-4.0[-cubox,raspberry-pi?]
	)
	dbus? (
		sys-apps/dbus
	)
	gbm? (
		>=dev-libs/libinput-1.10.5:=
		x11-libs/libxkbcommon
	)
	gles? (
		!raspberry-pi? (
			media-libs/mesa[gles2]
		)
	)
	!gles? (
		media-libs/glu
	)
	lcms? (
		>=media-libs/lcms-2.10:2
	)
	libusb? (
		virtual/libusb:1
	)
	lirc? (
		app-misc/lirc
	)
	mariadb? (
		dev-db/mariadb-connector-c:=
	)
	mysql? (
		dev-db/mysql-connector-c:=
	)
	nfs? (
		>=net-fs/libnfs-2.0.0:=
	)
	pipewire? (
		>=media-video/pipewire-0.3.24:=
	)
	pulseaudio? (
		media-libs/libpulse
	)
	raspberry-pi? (
		|| (
			media-libs/raspberrypi-userland
			media-libs/raspberrypi-userland-bin
			media-libs/mesa[gles2,video_cards_vc4]
		)
	)
	samba? (
		>=net-fs/samba-3.4.6[smbclient(+)]
	)
	system-ffmpeg? (
		media-video/ffmpeg:=[openssl,encode,postproc,vaapi?,vdpau?,X?]
	)
	!system-ffmpeg? (
		app-arch/bzip2
		media-libs/dav1d:=
	)
	udf? (
		>=dev-libs/libudfread-1.0.0
	)
	udev? (
		virtual/libudev:=
	)
	vaapi? (
		media-libs/libva:=[wayland?,X?]
	)
	vdpau? (
		|| (
			>=x11-libs/libvdpau-1.1
			>=x11-drivers/nvidia-drivers-180.51
		)
	)
	wayland? (
		>=x11-libs/libxkbcommon-0.4.1[wayland]
	)
	webserver? (
		>=net-libs/libmicrohttpd-0.9.55:=[messages(+)]
	)
	X? (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXrandr
	)
	xslt? (
		dev-libs/libxslt
		>=dev-libs/libxml2-2.9.4
	)
	zeroconf? (
		net-dns/avahi[dbus]
	)
"
RDEPEND="
	${COMMON_DEPEND}
	${COMMON_TARGET_DEPEND}
"
DEPEND="
	${COMMON_DEPEND}
	${COMMON_TARGET_DEPEND}
	dev-libs/rapidjson
	test? (
		>=dev-cpp/gtest-1.10.0
	)
	wayland? (
		>=dev-libs/wayland-protocols-1.7
	)
	X? (
		x11-base/xorg-proto
		x11-libs/libXrender
	)
"
BDEPEND="
	${COMMON_DEPEND}
	dev-build/cmake
	dev-lang/swig
	virtual/pkgconfig
	<=virtual/jre-17:*
	doc? (
		app-text/doxygen
	)
"

# bug #544020
CONFIG_CHECK="~IP_MULTICAST"
ERROR_IP_MULTICAST="
In some cases Kodi needs to access multicast addresses.
Please consider enabling IP_MULTICAST under Networking options.
"

PATCHES=(
	"${FILESDIR}"/${P}-VideoPlayerAudio-invalidate-previous-sync-type-after-Audio.patch
	"${FILESDIR}"/${P}-CDVDInputStreamFile-use-64K-read-chunk-size-when-filesystem.patch
	"${FILESDIR}"/${P}-swig-4.2.patch
	"${FILESDIR}"/${P}-binutils-2.41.patch
)

pkg_setup() {
	check_extra_config
	java-pkg-2_pkg_setup
	python-single-r1_pkg_setup
}

src_unpack() {
	if [[ ${PV} == *9999 ]] ; then
		git-r3_src_unpack
	else
		unpack ${MY_P}.tar.gz
	fi
}

src_prepare() {
	cmake_src_prepare

	# avoid long delays when powerkit isn't running #348580
	sed -i \
		-e '/dbus_connection_send_with_reply_and_block/s:-1:3000:' \
		xbmc/platform/linux/*.cpp || die

	# Add all possible names for kissfft libraries
	for datatype in {float,int16,int32,simd}; do
		sed -i \
			-e "s/\(find_library(KISSFFT_LIBRARY NAMES .*\)/\1 kissfft-${datatype} kissfft-${datatype}-openmp/" \
			cmake/modules/FindKissFFT.cmake || die
	done

	if use system-ffmpeg; then
		eapply "${FILESDIR}"/${P}-ffmpeg5.patch
		eapply "${FILESDIR}"/${P}-ffmpeg6.patch
		eapply "${FILESDIR}"/${P}-fix-crash-in-avcodec_parameters_from_context.patch
		eapply "${FILESDIR}"/${P}-smart_ptr-and-custom-destructor-for-AVCodecParameters.patch
	fi
}

src_configure() {
	local mycmakeargs=(
		-Wno-dev # less noise

		-DAPP_RENDER_SYSTEM=$(usex gles gles gl)
		-DCORE_PLATFORM_NAME=$(usev gbm)$(usev wayland)$(usev X x11)
		-Ddocdir="${EPREFIX}/usr/share/doc/${PF}"
		-DENABLE_TESTING=$(usex test)
		-DVERBOSE=ON

		# Enforce use of configured python interpeter
		-DPYTHON_PATH=$(python_get_library_path)
		-DPYTHON_VER=${EPYTHON##python} # wont work for pypy

		# Toolchain
		-DENABLE_CCACHE=OFF
		-DENABLE_CLANGFORMAT=OFF
		-DENABLE_CLANGTIDY=OFF
		-DENABLE_CPPCHECK=OFF
		-DENABLE_INCLUDEWHATYOUUSE=OFF
		# https://bugs.gentoo.org/show_bug.cgi?id=606124
		-DENABLE_GOLD=OFF
		-DENABLE_LLD=OFF
		-DENABLE_MOLD=OFF
		-DUSE_LTO=OFF

		# Features
		-DENABLE_AIRTUNES=$(usex airplay)
		-DENABLE_ALSA=$(usex alsa)
		-DENABLE_AVAHI=$(usex zeroconf)
		-DENABLE_BLUETOOTH=$(usex bluetooth)
		-DENABLE_BLURAY=$(usex bluray)
		-DENABLE_CAP=$(usex caps)
		-DENABLE_CEC=$(usex cec)
		-DENABLE_DBUS=$(usex dbus)
		-DENABLE_DVDCSS=$(usex css)
		-DENABLE_EVENTCLIENTS=ON # alway enable to have 'kodi-send' and filter extra staff in 'src_install()'
		-DENABLE_ISO9660PP=$(usex optical)
		-DENABLE_LCMS2=$(usex lcms)
		-DENABLE_LIRCCLIENT=$(usex lirc)
		-DENABLE_MARIADBCLIENT=$(usex mariadb)
		-DENABLE_MDNS=OFF # used only on Android
		-DENABLE_MICROHTTPD=$(usex webserver)
		-DENABLE_MYSQLCLIENT=$(usex mysql)
		-DENABLE_NFS=$(usex nfs)
		-DENABLE_OPENGL=$(usex !gles)
		-DENABLE_OPENGLES=$(usex gles)
		-DENABLE_OPTICAL=$(usex optical)
		-DENABLE_PIPEWIRE=$(usex pipewire)
		-DENABLE_PLIST=$(usex airplay)
		-DENABLE_PULSEAUDIO=$(usex pulseaudio)
		-DENABLE_SMBCLIENT=$(usex samba)
		-DENABLE_SNDIO=OFF
		-DENABLE_UDEV=$(usex udev)
		-DENABLE_UDFREAD=$(usex udf)
		-DENABLE_UPNP=$(usex upnp)
		-DENABLE_VAAPI=$(usex vaapi)
		-DENABLE_VDPAU=$(usex vdpau)
		-DENABLE_XSLT=$(usex xslt)

		#To bundle or not
		-DENABLE_INTERNAL_CROSSGUID=OFF
		-DENABLE_INTERNAL_DAV1D=OFF
		-DENABLE_INTERNAL_FFMPEG="$(usex !system-ffmpeg)"
		-DENABLE_INTERNAL_FLATBUFFERS=OFF
		-DENABLE_INTERNAL_FMT=OFF
		-DENABLE_INTERNAL_FSTRCMP=OFF
		-DENABLE_INTERNAL_GTEST=OFF
		-DENABLE_INTERNAL_KISSFFT=OFF
		-DENABLE_INTERNAL_PCRE=OFF
		-DENABLE_INTERNAL_RapidJSON=OFF
		-DENABLE_INTERNAL_SPDLOG=OFF
		-DENABLE_INTERNAL_TAGLIB=OFF
		-DENABLE_INTERNAL_UDFREAD=OFF

		-DWITH_FFMPEG=$(usex system-ffmpeg)

		-Dlibdvdnav_URL="${DISTDIR}/libdvdnav-${LIBDVDNAV_VERSION}.tar.gz"
		-Dlibdvdread_URL="${DISTDIR}/libdvdread-${LIBDVDREAD_VERSION}.tar.gz"
	)

	# Separated to avoid "Manually-specified variables were not used by the project:"
	use css && mycmakeargs+=( -Dlibdvdcss_URL="${DISTDIR}/libdvdcss-${LIBDVDCSS_VERSION}.tar.gz" )
	use !system-ffmpeg && mycmakeargs+=(
		-DFFMPEG_URL="${DISTDIR}/ffmpeg-${PN}-${FFMPEG_VERSION}-${CODENAME}-${FFMPEG_KODI_VERSION}.tar.gz"
	)
	use nfs && mycmakeargs+=( -DENABLE_INTERNAL_NFS=OFF )
	use !udev && mycmakeargs+=( -DENABLE_LIBUSB=$(usex libusb) )
	use X && use !gles && mycmakeargs+=( -DENABLE_GLX=ON )

	for flag in ${CPU_FLAGS[@]} ; do
		local name=${flag#cpu_flags_*_}
		mycmakeargs+=( -DENABLE_${name^^}=$(usex ${flag}) )
	done

	if ! is-flag -DNDEBUG && ! is-flag -D_DEBUG ; then
		# Kodi requires one of the 'NDEBUG' or '_DEBUG' defines
		append-cflags -DNDEBUG
		append-cxxflags -DNDEBUG
	fi

	# Violates ODR (bug #860984) and USE_LTO does spooky stuff
	# https://github.com/xbmc/xbmc/commit/cb72a22d54a91845b1092c295f84eeb48328921e
	filter-lto

	cmake_src_configure
}

src_compile() {
	cmake_src_compile all
	use doc && cmake_build doc
	use test && cmake_build kodi-test
}

src_test() {
	local -x CMAKE_SKIP_TESTS=(
		# Known failing, unreliable test
		# bug #743938
		TestCPUInfo.GetCPUFrequency
		# Test failure stemming from sci-libs/kissfft
		# The difference between output[2i] and (i==freq1?1.0:0.0) is inf, which exceeds 1e-7, where output[2i]
		# evaluates to inf,(i==freq1?1.0:0.0) evaluates to 0, and 1e-7 evaluates to 9.9999999999999995e-08.
		TestRFFT.SimpleSignal
		# bug #779184
		# https://github.com/xbmc/xbmc/issues/18594
		$(usev x86 TestDateTime.SetFromDBTime)
	)

	# see https://github.com/xbmc/xbmc/issues/17860#issuecomment-630120213
	local -x KODI_HOME="${BUILD_DIR}"

	cmake_src_test
}

src_install() {
	cmake_src_install

	# bug #457588
	pax-mark Em "${ED}"/usr/$(get_libdir)/${PN}/${PN}.bin

	newicon media/icon48x48.png kodi.png

	rm "${ED}"/usr/share/kodi/addons/skin.estuary/fonts/Roboto-Thin.ttf || die
	dosym ../../../../fonts/roboto/Roboto-Thin.ttf \
		usr/share/kodi/addons/skin.estuary/fonts/Roboto-Thin.ttf

	if use !eventclients ; then
		rm -f "${ED}"/usr/bin/kodi-ps3remote || die
		rm -f "${D}"$(python_get_sitedir)/kodi/ps3_remote.py || die
		rm -rf "${D}"$(python_get_sitedir)/kodi/ps3 || die
		rm -rf "${D}"$(python_get_sitedir)/kodi/bt || die
		rm -rf "${ED}"/usr/share/doc/${PF}/kodi-eventclients-dev || die
	fi

	python_optimize "${D}$(python_get_sitedir)"

	einstalldocs
	use doc && dodoc -r "${S}"/docs/html/
}

pkg_postinst() {
	xdg_pkg_postinst

	if use dbus ; then
		optfeature "getting battery level and active power source" sys-power/upower
		optfeature "control of shutdown, reboot, suspend, and hibernate" sys-auth/elogind sys-apps/systemd
		optfeature "storage management support (automounting, volume monitoring, etc)" sys-fs/udisks:2
	fi
}
