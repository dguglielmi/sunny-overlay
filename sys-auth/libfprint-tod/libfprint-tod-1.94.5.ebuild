# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson udev

DESCRIPTION="light fork of libfprint to expose internal Drivers API"
HOMEPAGE="https://gitlab.freedesktop.org/3v1n0/libfprint/-/tree/tod/"
SRC_URI="https://gitlab.freedesktop.org/3v1n0/libfprint/-/archive/v${PV}+tod1/libfprint-v${PV}+tod1.tar.bz2 -> ${P}.tar.bz2"

LICENSE="LGPL-2.1+"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="examples gtk-doc +introspection"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libgudev
	dev-libs/libgusb
	dev-libs/nss
	virtual/libusb:1=
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXv
	x11-libs/pixman
	!>=sys-auth/libfprint-1.90:0
"

DEPEND="${RDEPEND}"

BDEPEND="
	virtual/pkgconfig
	gtk-doc? ( dev-util/gtk-doc )
	introspection? ( dev-libs/gobject-introspection )
"

PATCHES=( ${FILESDIR}/${PN/-tod/}-0.8.2-fix-implicit-declaration.patch )

S="${WORKDIR}/${PN/-tod/}-v${PV}+tod1"

src_configure() {
	local emesonargs=(
		$(meson_use examples gtk-examples)
		$(meson_use gtk-doc doc)
		$(meson_use introspection)
		-Dtod=true
		-Ddrivers=all
		-Dudev_rules=enabled
		-Dudev_rules_dir=$(get_udevdir)/rules.d
		--libdir=/usr/$(get_libdir)
	)
	meson_src_configure
}
