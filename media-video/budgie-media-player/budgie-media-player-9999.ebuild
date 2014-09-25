# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=5

inherit gnome2

DESCRIPTION="Evolve OS's Simple Media Player"
HOMEPAGE="http://ikeydoherty.github.io/budgie/"

if [[ ${PV} == "9999" ]] ; then
    EGIT_REPO_URI="https://github.com/evolve-os/${PN}.git"
    SRC_URI=""
    KEYWORDS=""
    inherit git-r3 autotools
else
    SRC_URI="https://github.com/evolve-os/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
    KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="
    >=dev-libs/glib-2.38:2
    >=x11-libs/gtk+-3.12.0:3
    >=media-libs/gstreamer-1.0.10:1.0
	>=media-libs/gst-plugins-base-1.0.1:1.0
	>=media-libs/taglib-1.9.1"

if [[ ${PV} == "9999" ]] ; then
    RDEPEND="${RDEPEND}
        gnome-base/gnome-common:3"
fi

DEPEND="${RDEPEND}
    sys-libs/gdbm
    virtual/pkgconfig"

src_unpack() {
    if [[ ${PV} == "9999" ]] ; then
        git-r3_src_unpack
    else
        default_src_unpack
    fi
}

src_prepare() {
    if [[ ${PV} == "9999" ]] ; then
        eautoreconf
    else
        default_src_prepare
    fi
}
