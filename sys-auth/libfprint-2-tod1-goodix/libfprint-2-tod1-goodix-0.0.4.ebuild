# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit udev

DESCRIPTION="Goodix driver module for libfprint-2 Touch OEM Driver"
HOMEPAGE="https://git.launchpad.net/libfprint-2-tod1-goodix/"
SRC_URI="http://dell.archive.canonical.com/updates/pool/public/libf/libfprint-2-tod1-goodix/libfprint-2-tod1-goodix_${PV}-0ubuntu1somerville1.tar.gz"

LICENSE="Goodix"
SLOT="0"
S="${WORKDIR}/libfprint-2-tod1-goodix"
KEYWORDS="~amd64"

RESTRICT="bindist mirror"
QA_PREBUILT="*"

RDEPEND="sys-auth/libfprint[tod(-)]"

src_install() {
	udev_dorules lib/udev/rules.d/60-libfprint-2-tod1-goodix.rules
	exeinto usr/$(get_libdir)/libfprint-2/tod-1/
	doexe usr/lib/x86_64-linux-gnu/libfprint-2/tod-1/libfprint-tod-goodix-53xc-${PV}.so
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
