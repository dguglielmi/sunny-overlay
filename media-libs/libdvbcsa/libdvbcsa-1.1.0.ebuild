# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit eutils

DESCRIPTION="Free implementation of the DVB Common Scrambling Algorithm - DVB/CSA"
HOMEPAGE="http://www.videolan.org/developers/libdvbcsa.html"

if [ ${PV} == "9999" ]; then
	inherit autotools subversion
	ESVN_REPO_URI="svn://svn.videolan.org/libdvbcsa/trunk"
	KEYWORDS=""
else
	KEYWORDS="~alpha ~amd64 ~arm ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
	SRC_URI="http://download.videolan.org/pub/videolan/${PN}/${PV}/${P}.tar.gz"
fi


LICENSE="GPL-2"
SLOT="0"
IUSE="altivec debug mmx sse2 +static-libs uint32 uint64"

REQUIRED_USE="^^ ( altivec mmx sse2 uint32 uint64 )"

RDEPEND=""
DEPEND="virtual/libc
	sys-devel/gcc"

DOCS=( AUTHORS ChangeLog INSTALL NEWS README )

src_prepare() {
	epatch_user
	if [ ${PV} == "9999" ]; then
		eautoreconf || die
	fi
}

src_configure() {
	econf \
		$(use_enable altivec) \
		$(use_enable debug) \
		$(use_enable mmx) \
		$(use_enable sse2) \
		$(use_enable static-libs static) \
		$(use_enable uint32) \
		$(use_enable uint64) \
		--enable-shared
}
