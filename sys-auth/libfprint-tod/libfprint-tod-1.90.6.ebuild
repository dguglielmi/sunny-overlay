# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson udev

DESCRIPTION="light fork of libfprint to expose internal Drivers API"
HOMEPAGE="https://gitlab.freedesktop.org/3v1n0/libfprint/-/tree/tod/"
SRC_URI="https://gitlab.freedesktop.org/3v1n0/libfprint/-/archive/v${PV}+tod1/libfprint-v${PV}+tod1.tar.bz2 -> ${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="examples"

RDEPEND="dev-libs/glib:2
	dev-libs/nss
	>=dev-libs/libgusb-0.3.1
	!sys-auth/libfprint
	virtual/libusb:1=
	x11-libs/gtk+:3
	x11-libs/pixman
	x11-libs/libX11
	x11-libs/libXv"

DEPEND="${RDEPEND}
	dev-util/gtk-doc"

BDEPEND="virtual/pkgconfig"

PATCHES=( ${FILESDIR}/${PN/-tod/}-0.8.2-fix-implicit-declaration.patch )

S="${WORKDIR}/${PN/-tod/}-v${PV}+tod1"

src_configure() {
		local emesonargs=(
			-Ddoc=false
			-Dgtk-examples=$(usex examples true false)
			-Ddrivers=all
			-Dtod=true
			-Dudev_rules=true
			-Dudev_rules_dir=$(get_udevdir)/rules.d
			--libdir=/usr/$(get_libdir)
		)
		meson_src_configure
}
