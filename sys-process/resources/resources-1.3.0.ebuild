# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	ahash@0.8.6
	aho-corasick@1.1.2
	allocator-api2@0.2.16
	anyhow@1.0.75
	arrayref@0.3.7
	arrayvec@0.5.2
	autocfg@1.1.0
	base64@0.13.1
	bitflags@1.3.2
	bitflags@2.4.1
	blake2b_simd@0.5.11
	block@0.1.6
	bumpalo@3.14.0
	byteorder@1.5.0
	cairo-rs@0.18.3
	cairo-sys-rs@0.18.2
	cc@1.0.83
	cfg-expr@0.15.5
	cfg-if@1.0.0
	const-random-macro@0.1.16
	const-random@0.1.17
	constant_time_eq@0.1.5
	crossbeam-utils@0.8.17
	crunchy@0.2.2
	darling@0.10.2
	darling_core@0.10.2
	darling_macro@0.10.2
	dirs@1.0.5
	dlv-list@0.5.2
	env_logger@0.10.1
	equivalent@1.0.1
	errno-dragonfly@0.1.2
	errno@0.2.8
	errno@0.3.8
	expanduser@1.2.2
	field-offset@0.3.6
	fnv@1.0.7
	futures-channel@0.3.29
	futures-core@0.3.29
	futures-executor@0.3.29
	futures-io@0.3.29
	futures-macro@0.3.29
	futures-task@0.3.29
	futures-util@0.3.29
	gdk-pixbuf-sys@0.18.0
	gdk-pixbuf@0.18.3
	gdk4-sys@0.7.2
	gdk4@0.7.3
	getrandom@0.1.16
	getrandom@0.2.11
	gettext-rs@0.7.0
	gettext-sys@0.21.3
	gio-sys@0.18.1
	gio@0.18.4
	glib-macros@0.18.3
	glib-sys@0.18.1
	glib@0.18.4
	glob@0.3.1
	gobject-sys@0.18.0
	graphene-rs@0.18.1
	graphene-sys@0.18.1
	gsk4-sys@0.7.3
	gsk4@0.7.3
	gtk-macros@0.3.0
	gtk4-macros@0.7.2
	gtk4-sys@0.7.3
	gtk4@0.7.3
	hashbrown@0.14.3
	heck@0.4.1
	hermit-abi@0.3.3
	humantime@2.1.0
	ident_case@1.0.1
	indexmap@2.1.0
	is-terminal@0.4.9
	js-sys@0.3.66
	kernel32-sys@0.2.2
	lazy_static@1.4.0
	libadwaita-sys@0.5.3
	libadwaita@0.5.3
	libc@0.2.151
	libloading@0.7.4
	linux-raw-sys@0.4.12
	locale_config@0.3.0
	log@0.4.20
	malloc_buf@0.0.6
	memchr@2.6.4
	memoffset@0.9.0
	nix@0.27.1
	num-traits@0.2.17
	num_cpus@1.16.0
	nvml-wrapper-sys@0.7.0
	nvml-wrapper@0.9.0
	objc-foundation@0.1.1
	objc@0.2.7
	objc_id@0.1.1
	once_cell@1.19.0
	ordered-multimap@0.7.1
	pango-sys@0.18.0
	pango@0.18.3
	paste@1.0.14
	pin-project-lite@0.2.13
	pin-utils@0.1.0
	pkg-config@0.3.27
	plotters-backend@0.3.5
	plotters-cairo@0.5.0
	plotters@0.3.5
	pretty_env_logger@0.5.0
	proc-macro-crate@1.3.1
	proc-macro-crate@2.0.1
	proc-macro-error-attr@1.0.4
	proc-macro-error@1.0.4
	proc-macro2@1.0.70
	pwd@1.4.0
	quote@1.0.33
	redox_syscall@0.1.57
	redox_users@0.3.5
	regex-automata@0.4.3
	regex-syntax@0.8.2
	regex@1.10.2
	rmp-serde@1.1.2
	rmp@0.8.12
	rust-argon2@0.8.3
	rust-ini@0.20.0
	rustc_version@0.4.0
	rustix@0.38.28
	rustversion@1.0.14
	semver@1.0.20
	serde@1.0.193
	serde_derive@1.0.193
	serde_repr@0.1.17
	serde_spanned@0.6.4
	slab@0.4.9
	smallvec@1.11.2
	static_assertions@1.1.0
	strsim@0.9.3
	strum@0.25.0
	strum_macros@0.25.3
	syn@1.0.109
	syn@2.0.41
	syscalls@0.6.15
	sysconf@0.3.4
	system-deps@6.2.0
	target-lexicon@0.12.12
	temp-dir@0.1.11
	termcolor@1.4.0
	thiserror-impl@1.0.51
	thiserror@1.0.51
	tiny-keccak@2.0.2
	toml@0.8.2
	toml_datetime@0.6.3
	toml_edit@0.19.15
	toml_edit@0.20.2
	unescape@0.1.0
	unicode-ident@1.0.12
	uzers@0.11.3
	version-compare@0.1.1
	version_check@0.9.4
	wasi@0.11.0+wasi-snapshot-preview1
	wasi@0.9.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.89
	wasm-bindgen-macro-support@0.2.89
	wasm-bindgen-macro@0.2.89
	wasm-bindgen-shared@0.2.89
	wasm-bindgen@0.2.89
	web-sys@0.3.66
	winapi-build@0.1.1
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.6
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.2.8
	winapi@0.3.9
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.0
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.0
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.0
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.0
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.0
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.0
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.0
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.0
	winnow@0.5.28
	wrapcenum-derive@0.4.0
	zerocopy-derive@0.7.31
	zerocopy@0.7.31
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
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 CC-PD CC0-1.0
	GPL-3+ ISC MIT Unicode-DFS-2016
"

SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND="
	dev-libs/glib
	gui-libs/gtk:4
	>=gui-libs/libadwaita-1.4.0
	sys-apps/systemd
	sys-auth/polkit
	"
RDEPEND="${DEPEND}"
BDEPEND=">=virtual/rust-1.70"

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
