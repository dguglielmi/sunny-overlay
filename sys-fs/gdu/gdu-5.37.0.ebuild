# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Pretty fast disk usage analyzer written in Go."
HOMEPAGE="https://github.com/dundee/gdu"

SRC_URI="
	https://github.com/dundee/${PN}/releases/download/v${PV}/${P}.tgz
		-> ${P}.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND=">=dev-lang/go-1.25.0"

src_compile() {
	local build_info=(
		"-X 'github.com/dundee/${PN}/v${PV:0:1}/build.Version=${PV}'"
		"-X 'github.com/dundee/${PN}/v${PV:0:1}/build.User=$(id -u -n)'"
		"-X 'github.com/dundee/${PN}/v${PV:0:1}/build.Time=$(LC_ALL=C date)'"
	)

	ego build \
		-ldflags="-w ${build_info[*]}" \
		-o "${PN}" "./cmd/${PN}"
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
}

src_test() {
	ego test ./...
}
