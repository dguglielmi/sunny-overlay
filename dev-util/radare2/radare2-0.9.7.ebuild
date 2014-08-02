# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit base eutils

DESCRIPTION="Advanced command line hexadecimal editor and more"
HOMEPAGE="http://www.radare.org"
SRC_URI="http://www.radare.org/get/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ewf ssl"

RDEPEND="ssl? ( dev-libs/openssl:= )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	econf $(use ssl || echo --without-ssl ) \
		$(use ewf || echo --without-ewf )
}

src_install() {
	emake DESTDIR="${D}" INSTALL_PROGRAM="install" install
}
