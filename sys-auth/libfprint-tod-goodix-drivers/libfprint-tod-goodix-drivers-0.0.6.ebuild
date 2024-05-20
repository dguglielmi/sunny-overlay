# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit udev

DESCRIPTION="Goodix driver module for libfprint-2 Touch OEM Driver"
HOMEPAGE="https://git.launchpad.net/~oem-solutions-engineers/libfprint-2-tod1-goodix"
SRC_URI="
	https://git.launchpad.net/~oem-solutions-engineers/libfprint-2-tod1-goodix/plain/usr/lib/x86_64-linux-gnu/libfprint-2/tod-1/${PN/-drivers/}-53xc-${PV}.so?id=f17770af882d9b13832f16c77d739aa5387e2545
		-> ${PN/-drivers/}-53xc-${PV}.so
"

S="${WORKDIR}"

LICENSE="Goodix"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	sys-auth/libfprint-tod:2
"
RDEPEND="
	${DEPEND}
	acct-group/plugdev
"

RESTRICT="strip"

src_unpack() {
	:
}

src_install() {
	insopts -m0755
	insinto /usr/$(get_libdir)/libfprint-2/tod-1
	doins "${DISTDIR}"/libfprint-tod-goodix-53xc-${PV}.so

	udev_newrules "${FILESDIR}"/60-libfprint-2-tod1-goodix.rules 60-libfprint-2-tod1-goodix.rules
}
