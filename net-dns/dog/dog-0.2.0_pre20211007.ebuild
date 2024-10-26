# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	ansi_term@0.12.1
	anyhow@1.0.91
	atty@0.2.14
	base64@0.13.1
	bitflags@2.6.0
	bumpalo@3.16.0
	byteorder@1.5.0
	cc@1.1.31
	cfg-if@1.0.0
	core-foundation-sys@0.8.7
	core-foundation@0.9.4
	ctor@0.1.26
	datetime@0.5.2
	diff@0.1.13
	errno@0.3.9
	fastrand@2.1.1
	foreign-types-shared@0.1.1
	foreign-types@0.3.2
	getopts@0.2.21
	getrandom@0.2.15
	hermit-abi@0.1.19
	httparse@1.9.5
	ipconfig@0.2.2
	itoa@1.0.11
	js-sys@0.3.72
	json@0.12.4
	lazy_static@1.5.0
	libc@0.2.161
	linux-raw-sys@0.4.14
	log@0.4.22
	matches@0.1.10
	memchr@2.7.4
	native-tls@0.2.12
	once_cell@1.20.2
	openssl-macros@0.1.1
	openssl-probe@0.1.5
	openssl-src@300.4.0+3.4.0
	openssl-sys@0.9.104
	openssl@0.10.68
	output_vt100@0.1.3
	pkg-config@0.3.31
	ppv-lite86@0.2.20
	pretty_assertions@0.7.2
	proc-macro2@1.0.89
	quote@1.0.37
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	redox_syscall@0.1.57
	ring@0.16.20
	rustix@0.38.37
	rustls@0.19.1
	ryu@1.0.18
	schannel@0.1.26
	sct@0.6.1
	security-framework-sys@2.12.0
	security-framework@2.11.1
	serde@1.0.213
	serde_derive@1.0.213
	serde_json@1.0.132
	shlex@1.3.0
	socket2@0.3.19
	spin@0.5.2
	syn@1.0.109
	syn@2.0.85
	tempfile@3.13.0
	unic-char-property@0.9.0
	unic-char-range@0.9.0
	unic-common@0.9.0
	unic-idna-mapping@0.9.0
	unic-idna-punycode@0.9.0
	unic-idna@0.9.0
	unic-normal@0.9.0
	unic-ucd-bidi@0.9.0
	unic-ucd-hangul@0.9.0
	unic-ucd-normal@0.9.0
	unic-ucd-version@0.9.0
	unicode-ident@1.0.13
	unicode-width@0.1.14
	untrusted@0.7.1
	vcpkg@0.2.15
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.95
	wasm-bindgen-macro-support@0.2.95
	wasm-bindgen-macro@0.2.95
	wasm-bindgen-shared@0.2.95
	wasm-bindgen@0.2.95
	web-sys@0.3.72
	webpki-roots@0.21.1
	webpki@0.21.4
	widestring@0.4.3
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.52.0
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
	winreg@0.6.2
	zerocopy-derive@0.7.35
	zerocopy@0.7.35
"

declare -A GIT_CRATES=(
	[mutagen-core]='https://github.com/llogiq/mutagen;a6377c4c3f360afeb7a287c1c17e4b69456d5f53;mutagen-%commit%/mutagen-core'
	[mutagen-transform]='https://github.com/llogiq/mutagen;a6377c4c3f360afeb7a287c1c17e4b69456d5f53;mutagen-%commit%/mutagen-transform'
	[mutagen]='https://github.com/llogiq/mutagen;a6377c4c3f360afeb7a287c1c17e4b69456d5f53;mutagen-%commit%/mutagen'
)

inherit cargo

EGIT_COMMIT="721440b12ef01a812abe5dc6ced69af6e221fad5"

DESCRIPTION="dog is a command-line DNS client."
HOMEPAGE="https://github.com/ogham/dog"
SRC_URI="
	https://github.com/ogham/dog/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

LICENSE="EUPL-1.2"
# Dependent crate licenses
LICENSE+=" Apache-2.0 ISC MIT MPL-2.0 Unicode-DFS-2016"

SLOT="0"
KEYWORDS="~amd64"

BDEPEND="app-text/ronn-ng"
DEPEND="dev-libs/openssl"

PATCHES=(
	"${FILESDIR}"/${P}-update-crates.patch
	"${FILESDIR}"/${P}-manpage-fix.patch
)

src_prepare() {
	default

	ronn -r man/dog.1.md || die
}

src_install() {
	doman man/dog.1
	cargo_src_install
}
