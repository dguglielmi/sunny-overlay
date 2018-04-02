# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION=0.34

inherit gnome2 meson vala vcs-snapshot

DESCRIPTION="Organize your desktop with panels that hold your things"
HOMEPAGE="https://github.com/spheras/desktopfolder"
SRC_URI="https://github.com/spheras/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/libgee:0.8
	x11-libs/cairo[X]
	dev-libs/json-glib
	x11-libs/gdk-pixbuf
	x11-libs/libwnck:3
    x11-libs/gtksourceview:3
	x11-libs/cairo[X]"
DEPEND="${RDEPEND}
	$(vala_depend)"

src_prepare() {
	default
	vala_src_prepare
}
