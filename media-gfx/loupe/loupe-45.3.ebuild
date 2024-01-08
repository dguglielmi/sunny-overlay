# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Autogenerated by pycargoebuild 0.12.1
CRATES="
	addr2line@0.21.0
	adler@1.0.2
	aho-corasick@1.0.5
	anyhow@1.0.75
	arc-swap@1.6.0
	ashpd@0.6.2
	async-broadcast@0.5.1
	async-channel@1.9.0
	async-executor@1.5.1
	async-fs@1.6.0
	async-global-executor@2.3.1
	async-io@1.13.0
	async-lock@2.8.0
	async-process@1.7.0
	async-recursion@1.0.5
	async-std@1.12.0
	async-task@4.4.0
	async-trait@0.1.73
	atomic-waker@1.1.1
	autocfg@1.1.0
	backtrace@0.3.69
	bitflags@1.3.2
	bitflags@2.4.0
	block-buffer@0.10.4
	block@0.1.6
	blocking@1.3.1
	bumpalo@3.13.0
	bytemuck@1.13.1
	byteorder@1.4.3
	cairo-rs@0.18.0
	cairo-sys-rs@0.18.0
	cc@1.0.83
	cfg-expr@0.15.4
	cfg-if@1.0.0
	concurrent-queue@2.2.0
	cpufeatures@0.2.9
	crc32fast@1.3.2
	crossbeam-utils@0.8.16
	crypto-common@0.1.6
	derivative@2.2.0
	digest@0.10.7
	dunce@1.0.4
	enumflags2@0.7.7
	enumflags2_derive@0.7.7
	env_logger@0.10.0
	equivalent@1.0.1
	errno-dragonfly@0.1.2
	errno@0.3.3
	event-listener@2.5.3
	fastrand@1.9.0
	fastrand@2.0.0
	field-offset@0.3.6
	flate2@1.0.27
	foreign-types-macros@0.2.3
	foreign-types-shared@0.3.1
	foreign-types@0.5.0
	form_urlencoded@1.2.0
	futures-channel@0.3.28
	futures-core@0.3.28
	futures-executor@0.3.28
	futures-io@0.3.28
	futures-lite@1.13.0
	futures-macro@0.3.28
	futures-sink@0.3.28
	futures-task@0.3.28
	futures-util@0.3.28
	futures@0.3.28
	gdk-pixbuf-sys@0.18.0
	gdk-pixbuf@0.18.0
	gdk4-sys@0.7.2
	gdk4-wayland-sys@0.7.2
	gdk4-wayland@0.7.2
	gdk4-x11-sys@0.7.2
	gdk4-x11@0.7.2
	gdk4@0.7.2
	generic-array@0.14.7
	getrandom@0.2.10
	gettext-rs@0.7.0
	gettext-sys@0.21.3
	gimli@0.28.0
	gio-sys@0.18.1
	gio@0.18.1
	glib-macros@0.18.0
	glib-sys@0.18.1
	glib@0.18.1
	gloo-timers@0.2.6
	glycin-utils@0.1.0-rc
	glycin@0.1.0
	gobject-sys@0.18.0
	graphene-rs@0.18.1
	graphene-sys@0.18.1
	gsk4-sys@0.7.2
	gsk4@0.7.2
	gtk4-macros@0.7.2
	gtk4-sys@0.7.2
	gtk4@0.7.2
	gvdb-macros@0.1.9
	gvdb@0.5.2
	gweather-sys@4.3.0
	hashbrown@0.14.0
	heck@0.4.1
	hermit-abi@0.3.2
	hex@0.4.3
	humantime@2.1.0
	idna@0.4.0
	indexmap@2.0.0
	instant@0.1.12
	io-lifetimes@1.0.11
	is-terminal@0.4.9
	itoa@1.0.9
	jobserver@0.1.26
	js-sys@0.3.64
	kamadak-exif@0.5.5
	kv-log-macro@1.0.7
	lazy_static@1.4.0
	lcms2-sys@4.0.3
	lcms2@5.6.0
	libadwaita-sys@0.5.2
	libadwaita@0.5.2
	libc@0.2.147
	libgweather@4.3.0
	linux-raw-sys@0.3.8
	linux-raw-sys@0.4.5
	litrs@0.4.0
	locale_config@0.3.0
	log@0.4.20
	malloc_buf@0.0.6
	memchr@2.6.3
	memfd@0.6.3
	memmap2@0.7.1
	memoffset@0.7.1
	memoffset@0.9.0
	miniz_oxide@0.7.1
	mutate_once@0.1.1
	nix@0.26.4
	objc-foundation@0.1.1
	objc@0.2.7
	objc_id@0.1.1
	object@0.32.1
	once_cell@1.18.0
	ordered-stream@0.2.0
	pango-sys@0.18.0
	pango@0.18.0
	parking@2.1.0
	percent-encoding@2.3.0
	pin-project-lite@0.2.13
	pin-utils@0.1.0
	pkg-config@0.3.27
	polling@2.8.0
	ppv-lite86@0.2.17
	proc-macro-crate@1.3.1
	proc-macro-error-attr@1.0.4
	proc-macro-error@1.0.4
	proc-macro2@1.0.66
	quick-xml@0.30.0
	quote@1.0.33
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	redox_syscall@0.3.5
	regex-automata@0.3.8
	regex-syntax@0.7.5
	regex@1.9.5
	rgb@0.8.36
	rustc-demangle@0.1.23
	rustc_version@0.4.0
	rustix@0.37.23
	rustix@0.38.11
	ryu@1.0.15
	safe-transmute@0.11.2
	same-file@1.0.6
	semver@1.0.18
	serde@1.0.188
	serde_derive@1.0.188
	serde_json@1.0.105
	serde_repr@0.1.16
	serde_spanned@0.6.3
	sha1@0.10.5
	signal-hook-registry@1.4.1
	signal-hook@0.3.17
	slab@0.4.9
	smallvec@1.11.0
	socket2@0.4.9
	static_assertions@1.1.0
	syn@1.0.109
	syn@2.0.30
	system-deps@6.1.1
	target-lexicon@0.12.11
	temp-dir@0.1.11
	tempfile@3.8.0
	termcolor@1.2.0
	thiserror-impl@1.0.48
	thiserror@1.0.48
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	toml@0.7.6
	toml_datetime@0.6.3
	toml_edit@0.19.14
	tracing-attributes@0.1.26
	tracing-core@0.1.31
	tracing@0.1.37
	typenum@1.16.0
	uds_windows@1.0.2
	unicode-bidi@0.3.13
	unicode-ident@1.0.11
	unicode-normalization@0.1.22
	url@2.4.1
	value-bag@1.4.1
	version-compare@0.1.1
	version_check@0.9.4
	waker-fn@1.1.0
	walkdir@2.3.3
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.87
	wasm-bindgen-futures@0.4.37
	wasm-bindgen-macro-support@0.2.87
	wasm-bindgen-macro@0.2.87
	wasm-bindgen-shared@0.2.87
	wasm-bindgen@0.2.87
	web-sys@0.3.64
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.48.0
	windows-targets@0.48.5
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_msvc@0.48.5
	windows_i686_gnu@0.48.5
	windows_i686_msvc@0.48.5
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_msvc@0.48.5
	winnow@0.5.15
	xdg-home@1.0.0
	zbus@3.14.1
	zbus_macros@3.14.1
	zbus_names@2.6.0
	zvariant@3.15.0
	zvariant_derive@3.15.0
	zvariant_utils@1.0.1
"

inherit cargo gnome.org gnome2-utils meson xdg

DESCRIPTION="An image viewer application written with GTK 4, Libadwaita and Rust"
HOMEPAGE="https://apps.gnome.org/Loupe/"

SRC_URI+=" $(cargo_crate_uris ${CRATES})"

LICENSE="GPL-3+"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD MIT
	Unicode-DFS-2016
	|| ( LGPL-2.1+ MPL-2.0 )
"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND="
	>=gui-libs/gtk-4.12.0:4
	>=gui-libs/libadwaita-1.4.0
	>=dev-libs/libgweather-4.2.0
	media-libs/lcms:2
	"
RDEPEND="${DEPEND}
	>=gui-libs/glycin-loaders-0.1.2"
BDEPEND=">=virtual/rust-1.70"

src_configure() {
	meson_src_configure
	ln -s "${CARGO_HOME}" "${BUILD_DIR}/cargo-home" || die
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_desktop_database_update
	xdg_icon_cache_update
}
