# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/sourcekris/goRsaTool"

EGO_VENDOR=(
	"github.com/jbarham/primegen 8ce4838491a0"
	"github.com/kavehmz/prime v1.0.0"
	"github.com/sourcekris/goflint v1.0.0"
	"github.com/sourcekris/gogmpecm 8a5f196d84bc"
	"github.com/sourcekris/mathparse 232758c46ee7"
	"github.com/sourcekris/x509big e8ea46e23d32"
	"github.com/sourcekris/goflint v1.0.0"
)

EGIT_COMMIT="b73bceaed5922053d5c8760b1a16d60b1fae0869"

inherit golang-build golang-vcs-snapshot

DESCRIPTION="goRsaTool is an RSA tool for CTF challenges"
HOMEPAGE="https://github.com/sourcekris/goRsaTool"

SRC_URI="https://github.com/sourcekris/goRsaTool/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

KEYWORDS="amd64 x86"

LICENSE="Apache-2.0"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="sci-mathematics/gmp-ecm
	sci-mathematics/flint"

src_install() {
	newbin goRsaTool gorsatool
	dodoc src/github.com/sourcekris/goRsaTool/pastctfprimes.txt
}
