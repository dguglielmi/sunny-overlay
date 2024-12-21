# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler@1.0.2
	ahash@0.8.11
	aho-corasick@1.1.3
	allocator-api2@0.2.18
	anyhow@1.0.86
	arrayvec@0.7.4
	ash@0.38.0+1.3.281
	autocfg@1.2.0
	base64@0.22.1
	bincode@1.3.3
	bitflags@1.3.2
	bitflags@2.5.0
	block-buffer@0.10.4
	block@0.1.6
	bstr@1.9.1
	bytemuck@1.16.0
	bytemuck_derive@1.6.1
	cairo-rs@0.19.4
	cairo-sys-rs@0.19.2
	cargo-util@0.2.11
	cc@1.0.96
	cc@1.0.98
	cfg-expr@0.15.8
	cfg-if@1.0.0
	cfg_aliases@0.2.1
	const-random-macro@0.1.16
	const-random@0.1.18
	core-foundation-sys@0.8.6
	core-foundation@0.9.4
	cpufeatures@0.2.12
	crc32fast@1.4.2
	crossbeam-deque@0.8.5
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.20
	crunchy@0.2.2
	crypto-common@0.1.6
	dbus-crossroads@0.5.2
	dbus@0.9.7
	digest@0.10.7
	dlv-list@0.5.2
	drm-ffi@0.8.0
	drm-fourcc@2.2.0
	drm-sys@0.7.0
	drm@0.12.0
	egl@0.2.7
	either@1.12.0
	equivalent@1.0.1
	errno-sys@0.2.0
	errno@0.3.9
	fallible-iterator@0.3.0
	fallible-streaming-iterator@0.1.9
	fastrand@2.1.0
	field-offset@0.3.6
	filetime@0.2.23
	flate2@1.0.30
	form_urlencoded@1.2.1
	futures-channel@0.3.30
	futures-core@0.3.30
	futures-executor@0.3.30
	futures-io@0.3.30
	futures-macro@0.3.30
	futures-task@0.3.30
	futures-util@0.3.30
	gbm-sys@0.3.0
	gbm@0.15.0
	gdk-pixbuf-sys@0.19.5
	gdk-pixbuf@0.19.2
	gdk4-sys@0.8.2
	gdk4@0.8.2
	generic-array@0.14.7
	getrandom@0.2.14
	getrandom@0.2.15
	gettext-rs@0.7.0
	gettext-sys@0.21.3
	gio-sys@0.19.5
	gio@0.19.5
	glib-macros@0.19.5
	glib-sys@0.19.5
	glib@0.19.5
	globset@0.4.14
	gobject-sys@0.19.5
	graphene-rs@0.19.2
	graphene-sys@0.19.5
	gsk4-sys@0.8.2
	gsk4@0.8.2
	gtk4-macros@0.8.2
	gtk4-sys@0.8.2
	gtk4@0.8.2
	hashbrown@0.14.5
	hashlink@0.9.0
	heck@0.5.0
	hex@0.4.3
	idna@0.5.0
	ignore@0.4.22
	indexmap@2.2.6
	itoa@1.0.11
	jobserver@0.1.31
	khronos@0.1.2
	lazy_static@1.4.0
	libadwaita-sys@0.6.0
	libadwaita@0.6.0
	libc@0.1.12
	libc@0.2.154
	libc@0.2.155
	libdbus-sys@0.2.5
	libloading@0.8.3
	libsqlite3-sys@0.28.0
	libudev-sys@0.1.4
	linux-raw-sys@0.4.14
	linux-raw-sys@0.6.4
	locale_config@0.3.0
	log@0.4.21
	malloc_buf@0.0.6
	memchr@2.7.2
	memoffset@0.9.1
	miniz_oxide@0.7.3
	miow@0.6.0
	nix@0.29.0
	objc-foundation@0.1.1
	objc@0.2.7
	objc_id@0.1.1
	once_cell@1.19.0
	ordered-multimap@0.7.3
	pango-sys@0.19.5
	pango@0.19.5
	percent-encoding@2.3.1
	pin-project-lite@0.2.14
	pin-utils@0.1.0
	pkg-config@0.3.30
	proc-macro-crate@3.1.0
	proc-macro2@1.0.81
	proc-macro2@1.0.83
	quote@1.0.36
	rayon-core@1.12.1
	rayon@1.10.0
	redox_syscall@0.4.1
	regex-automata@0.4.6
	regex-syntax@0.8.3
	regex@1.10.4
	ring@0.17.8
	rusqlite@0.31.0
	rust-ini@0.21.0
	rustc_version@0.4.0
	rustix@0.38.34
	rustls-pki-types@1.7.0
	rustls-webpki@0.102.4
	rustls@0.22.4
	ryu@1.0.17
	ryu@1.0.18
	same-file@1.0.6
	semver@1.0.22
	serde@1.0.200
	serde@1.0.202
	serde_derive@1.0.200
	serde_derive@1.0.202
	serde_json@1.0.116
	serde_json@1.0.117
	serde_spanned@0.6.5
	sha2@0.10.8
	shell-escape@0.1.5
	slab@0.4.9
	smallvec@1.13.2
	spin@0.9.8
	static_assertions@1.1.0
	subtle@2.5.0
	syn@2.0.60
	syn@2.0.66
	system-deps@6.2.2
	tar@0.4.40
	target-lexicon@0.12.14
	temp-dir@0.1.13
	tempfile@3.10.1
	textdistance@1.0.2
	thiserror-impl@1.0.59
	thiserror-impl@1.0.61
	thiserror@1.0.59
	thiserror@1.0.61
	tiny-keccak@2.0.2
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	toml@0.8.12
	toml_datetime@0.6.5
	toml_edit@0.21.1
	toml_edit@0.22.12
	tracing-attributes@0.1.27
	tracing-core@0.1.32
	tracing@0.1.40
	trim-in-place@0.1.7
	typenum@1.17.0
	unicode-bidi@0.3.15
	unicode-ident@1.0.12
	unicode-normalization@0.1.23
	untrusted@0.9.0
	ureq@2.9.7
	url@2.5.0
	vcpkg@0.2.15
	version-compare@0.2.0
	version_check@0.9.4
	walkdir@2.5.0
	wasi@0.11.0+wasi-snapshot-preview1
	webpki-roots@0.26.1
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.8
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.5
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.5
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.5
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.5
	windows_i686_gnullvm@0.52.5
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.5
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.5
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.5
	winnow@0.5.40
	winnow@0.6.7
	xattr@1.3.1
	zerocopy-derive@0.7.32
	zerocopy@0.7.32
	zeroize@1.7.0
"

inherit cargo gnome2-utils meson xdg

NVTOP_SNAPSHOT="45a1796375cd617d16167869bb88e5e69c809468"

DESCRIPTION="Monitor your CPU, Memory, Disk, Network and GPU usage"
HOMEPAGE="https://missioncenter.io https://gitlab.com/mission-center-devs/mission-center"
SRC_URI="https://gitlab.com/${PN}-devs/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2
	https://github.com/Syllo/nvtop/archive/${NVTOP_SNAPSHOT}.tar.gz -> nvtop-${NVTOP_SNAPSHOT}.tar.gz
	${CARGO_CRATE_URIS}
"

S="${WORKDIR}/${PN}-v${PV}"

LICENSE="GPL-3"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD CC0-1.0 ISC MIT
	Unicode-DFS-2016
"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	>=dev-libs/glib-2.80.0
	dev-python/pygobject
	>=gui-libs/gtk-4.14.0:4
	>=gui-libs/libadwaita-1.5.2
	media-libs/mesa[egl(+),gbm(+)]
	sys-apps/dmidecode
	virtual/libudev
	x11-libs/libdrm
	>=x11-libs/pango-1.52.0
"
RDEPEND="${DEPEND}"
BDEPEND="
	${DEPEND}
	>=dev-util/blueprint-compiler-0.14.0
"

PATCHES="
	"${FILESDIR}"/${PN}-0.4.4-nvtop-source-dir.patch
"

src_prepare() {
	for p in "${S}"/src/sys_info_v2/gatherer/3rdparty/nvtop/patches/*.patch; do
		eapply -d "${WORKDIR}/nvtop-${NVTOP_SNAPSHOT}" -p1 -- "${p}"
	done
	default
}

src_configure() {
	meson_src_configure
	ln -s "${CARGO_HOME}" "${BUILD_DIR}/cargo-home" || die
	ln -s "${CARGO_HOME}" "${BUILD_DIR}/src/sys_info_v2/gatherer/cargo-home" || die
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_pkg_postrm
}
