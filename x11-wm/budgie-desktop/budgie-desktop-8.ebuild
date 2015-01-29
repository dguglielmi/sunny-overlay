# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=5

VALA_MIN_API_VERSION="0.22"
GNOME2_LA_PUNT="yes"

inherit gnome2 vala

DESCRIPTION="Evolve OS's desktop"
HOMEPAGE="https://evolve-os.com/budgie/"

if [[ ${PV} == "9999" ]] ; then
    EGIT_REPO_URI="https://github.com/evolve-os/${PN}.git"
    SRC_URI=""
    KEYWORDS=""
    inherit git-r3 autotools
else
    SRC_URI="https://github.com/evolve-os/${PN}/releases/download/v${PV}/${P}.tar.xz -> ${P}.tar.xz"
    KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="
    >=media-sound/pulseaudio-4.0[glib]
    >=x11-libs/gtk+-3.10.1:3
    >=sys-power/upower-0.9.20[introspection]
    >=gnome-base/gnome-menus-3.10.1
    >=x11-libs/libwnck-3.4.7
    >=x11-wm/mutter-3.10.1
    >=dev-libs/glib-2.38.0
    dev-libs/libgee:0.8
    >=dev-libs/libpeas-1.0"

if [[ ${PV} == "9999" ]] ; then
    RDEPEND="${RDEPEND}
        gnome-base/gnome-common:3"
fi

DEPEND="${RDEPEND}
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

src_configure() {
    gnome2_src_configure \
        VALAC=$(type -P true)
}

src_compile() {
    local valaver="$(vala_best_api_version)"
    emake VALAC="$(type -p valac-${valaver})"
}
