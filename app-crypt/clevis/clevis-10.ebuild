# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools systemd

DESCRIPTION="Clevis is a plugable framework for automated decryption"
HOMEPAGE="https://latchset.github.io/"
SRC_URI="https://github.com/latchset/${PN}/releases/download/v${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dracut"

DEPEND=">=sys-fs/luksmeta-8
	>=dev-libs/openssl-1.0.2
	>=dev-libs/jansson-2.10
	>=dev-libs/jose-8
	dev-libs/libpwquality
	sys-fs/udisks:2
	sys-apps/systemd
	dracut? ( sys-kernel/dracut )
	>=sys-process/audit-2.7.8"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/${P}-dont-check-dracut.patch )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--with-systemdsystemunitdir="$(systemd_get_systemunitdir)"
		--with-dracutmodulesdir="${PREFIX}/usr/lib/dracut/modules.d"
	)

	econf "${myconf[@]}"
}

src_install() {
	default

	if ! use dracut; then
		rm -rf ${D}/usr/lib/dracut
	fi
}
