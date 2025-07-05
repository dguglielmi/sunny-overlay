# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.24.2
	adler2@2.0.0
	aho-corasick@1.1.3
	anstream@0.6.18
	anstyle-parse@0.2.6
	anstyle-query@1.1.2
	anstyle-wincon@3.0.7
	anstyle@1.0.10
	anyhow@1.0.97
	async-channel@2.3.1
	autocfg@1.4.0
	backtrace@0.3.74
	base64@0.22.1
	bitflags@2.9.0
	block@0.1.6
	bumpalo@3.17.0
	byteorder@1.5.0
	cairo-rs@0.20.7
	cairo-sys-rs@0.20.7
	cc@1.2.17
	cfg-expr@0.17.2
	cfg-if@1.0.0
	cfg_aliases@0.2.1
	clap@4.5.34
	clap_builder@4.5.34
	clap_derive@4.5.32
	clap_lex@0.7.4
	colorchoice@1.0.3
	concurrent-queue@2.5.0
	const-random-macro@0.1.16
	const-random@0.1.18
	convert_case@0.6.0
	crossbeam-utils@0.8.21
	crunchy@0.2.3
	darling@0.20.11
	darling_core@0.20.11
	darling_macro@0.20.11
	diff@0.1.13
	dlv-list@0.5.2
	env_logger@0.10.2
	equivalent@1.0.2
	errno-dragonfly@0.1.2
	errno@0.2.8
	event-listener-strategy@0.5.4
	event-listener@5.4.0
	field-offset@0.3.6
	fnv@1.0.7
	futures-channel@0.3.31
	futures-core@0.3.31
	futures-executor@0.3.31
	futures-io@0.3.31
	futures-macro@0.3.31
	futures-task@0.3.31
	futures-util@0.3.31
	gdk-pixbuf-sys@0.20.7
	gdk-pixbuf@0.20.9
	gdk4-sys@0.9.6
	gdk4@0.9.6
	getrandom@0.2.15
	gettext-rs@0.7.2
	gettext-sys@0.22.5
	gimli@0.31.1
	gio-sys@0.20.9
	gio@0.20.9
	glib-macros@0.20.7
	glib-sys@0.20.9
	glib@0.20.9
	glob@0.3.2
	gobject-sys@0.20.9
	graphene-rs@0.20.9
	graphene-sys@0.20.7
	gsk4-sys@0.9.6
	gsk4@0.9.6
	gtk4-macros@0.9.5
	gtk4-sys@0.9.6
	gtk4@0.9.6
	hashbrown@0.14.5
	hashbrown@0.15.2
	heck@0.5.0
	hermit-abi@0.3.9
	hermit-abi@0.5.0
	humantime@2.2.0
	ident_case@1.0.1
	indexmap@2.8.0
	is-terminal@0.4.16
	is_terminal_polyfill@1.70.1
	js-sys@0.3.77
	kernel32-sys@0.2.2
	kinded@0.3.0
	kinded_macros@0.3.0
	lazy-regex-proc_macros@3.4.1
	lazy-regex@3.4.1
	lazy_static@1.5.0
	libadwaita-sys@0.7.2
	libadwaita@0.7.2
	libc@0.2.171
	libloading@0.8.6
	locale_config@0.3.0
	log@0.4.27
	malloc_buf@0.0.6
	memchr@2.7.4
	memoffset@0.9.1
	miniz_oxide@0.8.5
	nix@0.29.0
	num-traits@0.2.19
	num_cpus@1.16.0
	nutype@0.6.1
	nutype_macros@0.6.1
	nvml-wrapper-sys@0.8.0
	nvml-wrapper@0.10.0
	objc-foundation@0.1.1
	objc@0.2.7
	objc_id@0.1.1
	object@0.36.7
	once_cell@1.21.3
	ordered-multimap@0.7.3
	pango-sys@0.20.9
	pango@0.20.9
	parking@2.2.1
	paste@1.0.15
	path-dedot@3.1.1
	pin-project-lite@0.2.16
	pin-utils@0.1.0
	pkg-config@0.3.32
	plotters-backend@0.3.7
	plotters-cairo@0.7.0
	plotters@0.3.7
	pretty_assertions@1.4.1
	pretty_env_logger@0.5.0
	proc-macro-crate@3.3.0
	proc-macro2@1.0.94
	quote@1.0.40
	regex-automata@0.4.9
	regex-syntax@0.8.5
	regex@1.11.1
	rmp-serde@1.3.0
	rmp@0.8.14
	ron@0.9.0
	rust-ini@0.21.1
	rustc-demangle@0.1.24
	rustc_version@0.4.1
	rustversion@1.0.20
	semver@1.0.26
	serde@1.0.219
	serde_derive@1.0.219
	serde_repr@0.1.20
	serde_spanned@0.6.8
	shlex@1.3.0
	slab@0.4.9
	smallvec@1.14.0
	static_assertions@1.1.0
	strsim@0.11.1
	strum@0.27.1
	strum_macros@0.27.1
	syn@2.0.100
	syscalls@0.6.18
	sysconf@0.3.4
	system-deps@7.0.3
	target-lexicon@0.12.16
	temp-dir@0.1.14
	termcolor@1.4.1
	thiserror-impl@1.0.69
	thiserror-impl@2.0.12
	thiserror@1.0.69
	thiserror@2.0.12
	tiny-keccak@2.0.2
	toml@0.8.20
	toml_datetime@0.6.8
	toml_edit@0.22.24
	trim-in-place@0.1.7
	unescape@0.1.0
	unicode-ident@1.0.18
	unicode-segmentation@1.12.0
	urlencoding@2.1.3
	utf8parse@0.2.2
	uzers@0.12.1
	version-compare@0.2.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.100
	wasm-bindgen-macro-support@0.2.100
	wasm-bindgen-macro@0.2.100
	wasm-bindgen-shared@0.2.100
	wasm-bindgen@0.2.100
	web-sys@0.3.77
	winapi-build@0.1.1
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.9
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.2.8
	winapi@0.3.9
	windows-sys@0.59.0
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
	winnow@0.7.4
	wrapcenum-derive@0.4.1
	yansi@1.0.1
"

RUST_MIN_VER="1.85.0"

inherit cargo gnome2-utils meson xdg

DESCRIPTION="Resources is a simple yet powerful monitor for your system"
HOMEPAGE="https://github.com/nokyan/resources"
SRC_URI="https://github.com/nokyan/resources/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="GPL-3"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 CC0-1.0 ISC MIT
	Unicode-3.0
"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	dev-libs/glib
	>=gui-libs/gtk-4.18.0:4
	>=gui-libs/libadwaita-1.7.0
	sys-auth/polkit
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

# Rust.
QA_FLAGS_IGNORED=(
	/usr/libexec/resources/resources-adjust
	/usr/libexec/resources/resources-kill
	/usr/libexec/resources/resources-processes
	/usr/bin/resources
)

QA_PRESTRIPPED="${QA_FLAGS_IGNORED[*]}"

src_configure() {
	local emesonargs=(
		-Dprofile=default
	)
	meson_src_configure
	ln -s "${CARGO_HOME}" "${BUILD_DIR}/cargo" || die
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_pkg_postrm
}
