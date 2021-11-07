# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit udev

DESCRIPTION="Goodix driver module for libfprint-2 Touch OEM Driver"
HOMEPAGE="https://git.launchpad.net/~oem-solutions-engineers/libfprint-2-tod1-goodix/+git/libfprint-2-tod1-goodix"
SRC_URI="${HOMEPAGE}/plain/usr/lib/x86_64-linux-gnu/libfprint-2/tod-1/libfprint-tod-goodix-53xc-0.0.6.so?&id=f17770af882d9b13832f16c77d739aa5387e2545 -> libfprint-tod-goodix-53xc-0.0.6.so"

LICENSE="Goodix"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip"

DEPEND="sys-auth/libfprint-tod:2"
RDEPEND="${DEPEND}
	acct-group/plugdev"
BDEPEND=""

S="${WORKDIR}"

src_unpack() {
	:
}

src_install() {
	insopts -m0755
	insinto "${EPREFIX}/usr/$(get_libdir)/libfprint-2/tod-1"
	doins "${DISTDIR}/libfprint-tod-goodix-53xc-${PV}.so"

	udev_newrules "${FILESDIR}/60-libfprint-2-tod1-goodix.rules" 60-libfprint-2-tod1-goodix.rules
}
