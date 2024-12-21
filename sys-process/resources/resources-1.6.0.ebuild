# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.22.0
	adler@1.0.2
	aho-corasick@1.1.3
	anstream@0.6.15
	anstyle-parse@0.2.5
	anstyle-query@1.1.1
	anstyle-wincon@3.0.4
	anstyle@1.0.8
	anyhow@1.0.86
	async-channel@2.3.1
	autocfg@1.3.0
	backtrace@0.3.73
	base64@0.21.7
	bitflags@2.6.0
	block@0.1.6
	bumpalo@3.16.0
	byteorder@1.5.0
	cairo-rs@0.20.0
	cairo-sys-rs@0.20.0
	cc@1.0.98
	cfg-expr@0.15.8
	cfg-if@1.0.0
	cfg_aliases@0.2.1
	clap@4.5.16
	clap_builder@4.5.15
	clap_derive@4.5.13
	clap_lex@0.7.2
	colorchoice@1.0.2
	concurrent-queue@2.5.0
	const-random-macro@0.1.16
	const-random@0.1.18
	convert_case@0.6.0
	crossbeam-utils@0.8.20
	crunchy@0.2.2
	darling@0.20.9
	darling_core@0.20.9
	darling_macro@0.20.9
	dlv-list@0.5.2
	env_logger@0.10.2
	equivalent@1.0.1
	errno-dragonfly@0.1.2
	errno@0.2.8
	event-listener-strategy@0.5.2
	event-listener@5.3.1
	field-offset@0.3.6
	fnv@1.0.7
	futures-channel@0.3.30
	futures-core@0.3.30
	futures-executor@0.3.30
	futures-io@0.3.30
	futures-macro@0.3.30
	futures-task@0.3.30
	futures-util@0.3.30
	gdk-pixbuf-sys@0.20.0
	gdk-pixbuf@0.20.0
	gdk4-sys@0.9.0
	gdk4@0.9.0
	getrandom@0.2.15
	gettext-rs@0.7.0
	gettext-sys@0.21.3
	gimli@0.29.0
	gio-sys@0.20.0
	gio@0.20.0
	glib-macros@0.20.0
	glib-sys@0.20.0
	glib@0.20.0
	glob@0.3.1
	gobject-sys@0.20.0
	graphene-rs@0.20.0
	graphene-sys@0.20.0
	gsk4-sys@0.9.0
	gsk4@0.9.0
	gtk-macros@0.3.0
	gtk4-macros@0.9.0
	gtk4-sys@0.9.0
	gtk4@0.9.0
	hashbrown@0.14.5
	heck@0.5.0
	hermit-abi@0.3.9
	humantime@2.1.0
	ident_case@1.0.1
	indexmap@2.2.6
	is-terminal@0.4.12
	is_terminal_polyfill@1.70.1
	js-sys@0.3.69
	kernel32-sys@0.2.2
	kinded@0.3.0
	kinded_macros@0.3.0
	lazy_static@1.4.0
	libadwaita-sys@0.7.0
	libadwaita@0.7.0
	libc@0.2.158
	libloading@0.8.3
	locale_config@0.3.0
	log@0.4.22
	malloc_buf@0.0.6
	memchr@2.7.4
	memoffset@0.9.1
	miniz_oxide@0.7.4
	nix@0.29.0
	num-traits@0.2.19
	num_cpus@1.16.0
	nutype@0.4.3
	nutype_macros@0.4.3
	nvml-wrapper-sys@0.8.0
	nvml-wrapper@0.10.0
	objc-foundation@0.1.1
	objc@0.2.7
	objc_id@0.1.1
	object@0.36.1
	once_cell@1.19.0
	ordered-multimap@0.7.3
	pango-sys@0.20.0
	pango@0.20.0
	parking@2.2.0
	paste@1.0.15
	pin-project-lite@0.2.14
	pin-utils@0.1.0
	pkg-config@0.3.30
	plotters-backend@0.3.6
	plotters-cairo@0.7.0
	plotters@0.3.6
	pretty_env_logger@0.5.0
	proc-macro-crate@3.1.0
	proc-macro2@1.0.85
	quote@1.0.36
	regex-automata@0.4.6
	regex-syntax@0.8.3
	regex@1.10.6
	rmp-serde@1.3.0
	rmp@0.8.14
	ron@0.8.1
	rust-ini@0.21.1
	rustc-demangle@0.1.24
	rustc_version@0.4.0
	rustversion@1.0.17
	semver@1.0.23
	serde@1.0.208
	serde_derive@1.0.208
	serde_repr@0.1.19
	serde_spanned@0.6.6
	slab@0.4.9
	smallvec@1.13.2
	static_assertions@1.1.0
	strsim@0.11.1
	strum@0.26.3
	strum_macros@0.26.4
	syn@2.0.72
	syscalls@0.6.18
	sysconf@0.3.4
	system-deps@7.0.1
	target-lexicon@0.12.14
	temp-dir@0.1.13
	termcolor@1.4.1
	thiserror-impl@1.0.61
	thiserror@1.0.61
	tiny-keccak@2.0.2
	toml@0.8.14
	toml_datetime@0.6.6
	toml_edit@0.21.1
	toml_edit@0.22.14
	trim-in-place@0.1.7
	unescape@0.1.0
	unicode-ident@1.0.12
	unicode-segmentation@1.11.0
	urlencoding@2.1.3
	utf8parse@0.2.2
	uzers@0.12.1
	version-compare@0.2.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.92
	wasm-bindgen-macro-support@0.2.92
	wasm-bindgen-macro@0.2.92
	wasm-bindgen-shared@0.2.92
	wasm-bindgen@0.2.92
	web-sys@0.3.69
	winapi-build@0.1.1
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.8
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.2.8
	winapi@0.3.9
	windows-sys@0.52.0
	windows-targets@0.52.5
	windows_aarch64_gnullvm@0.52.5
	windows_aarch64_msvc@0.52.5
	windows_i686_gnu@0.52.5
	windows_i686_gnullvm@0.52.5
	windows_i686_msvc@0.52.5
	windows_x86_64_gnu@0.52.5
	windows_x86_64_gnullvm@0.52.5
	windows_x86_64_msvc@0.52.5
	winnow@0.5.40
	winnow@0.6.11
	wrapcenum-derive@0.4.1
"

inherit cargo gnome2-utils meson xdg

DESCRIPTION="Resources is a simple yet powerful monitor for your system"
HOMEPAGE="https://github.com/nokyan/resources"
SRC_URI="https://github.com/nokyan/resources/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="GPL-3"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 CC0-1.0 GPL-3+ ISC
	MIT Unicode-DFS-2016
"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	dev-libs/glib
	gui-libs/gtk:4
	>=gui-libs/libadwaita-1.5.0
	sys-auth/polkit
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

# Rust.
QA_FLAGS_IGNORED=(
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
