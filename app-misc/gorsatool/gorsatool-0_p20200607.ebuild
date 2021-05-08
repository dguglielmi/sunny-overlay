# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/sourcekris/goRsaTool"

EGO_VENDOR=(
    "github.com/sourcekris/goflint f23b1b2709282f6b7d2f86842301c46aafdaf507"
    "github.com/sourcekris/gogmpecm c6536ae30853abdc238aed082ffd5b723cb66b84"
    "github.com/sourcekris/mathparse dc40b3863ac840b889536fda2eac0244d7794a24"
    "github.com/sourcekris/x509big 321a26314a1d6bc4edf904a477d39293795fb72a"
    "github.com/jbarham/primegen 8ce4838491a027d937a87fd521b3b11aabaeb568"
    "github.com/kavehmz/prime 789f3f91353209ceb30376f0c92374aacc82d9bf"
)

EGIT_COMMIT="b6524bfca6bdaf6ae4d79e9eb08a8ad2d07e326e"

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
