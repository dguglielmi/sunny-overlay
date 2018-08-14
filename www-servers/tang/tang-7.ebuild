# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools systemd

DESCRIPTION="Tang is a server for binding data to network presence"
HOMEPAGE="https://latchset.github.io/"
SRC_URI="https://github.com/latchset/${PN}/releases/download/v${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-text/asciidoc
	>=net-libs/http-parser-2.8.0
	sys-apps/systemd
	>=dev-libs/jose-8"
RDEPEND="${DEPEND}"

src_configure() {
	local myconf=(
		--localstatedir="${EPREFIX}/var"
		--with-systemdsystemunitdir="$(systemd_get_systemunitdir)"
	)

	econf "${myconf[@]}"
}
