# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_COMMIT="20fd771a678a241abbb57152e3c2d9a8eee353cb"

DESCRIPTION="lssecrets lists all secret items in a secret service using libsecret"
HOMEPAGE="https://gitlab.com/GrantMoyer/lssecret"
SRC_URI="
	https://gitlab.com/GrantMoyer/lssecret/-/archive/${EGIT_COMMIT}.tar.bz2
		-> ${P}.tar.bz2
"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	app-crypt/libsecret
"
RDEPEND="${DEPEND}"
BDEPEND="
	${DEPEND}
	virtual/pkgconfig
"

src_prepare() {
	sed -i '/$(CXX)/s#-O3#$(CXXFLAGS)#1' Makefile || die

	default
}

src_install() {
	dobin lssecret
}
