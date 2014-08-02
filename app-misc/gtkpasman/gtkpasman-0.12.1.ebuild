# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit gnome2-utils eutils

DESCRIPTION="A GTK+ passwords manager for system and network administrators"
HOMEPAGE="http://gtkpasman.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtkpasman/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="nls"

RDEPEND="app-crypt/gnupg
	gnome-base/dconf"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=dev-util/intltool-0.50
	x11-libs/gtk+:3
	nls? ( sys-devel/gettext )"

src_configure() {
	econf \
	$(use_enable nls)

}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}

