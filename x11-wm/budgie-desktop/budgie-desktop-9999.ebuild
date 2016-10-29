# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=5

VALA_MIN_API_VERSION="0.28"
GNOME2_LA_PUNT="yes"

inherit gnome2 vala

DESCRIPTION="Solus Project's desktop"
HOMEPAGE="https://solus-project.com/budgie/"

if [[ ${PV} == "9999" ]] ; then
    EGIT_REPO_URI="https://github.com/solus-project/${PN}.git"
    SRC_URI=""
    KEYWORDS=""
    inherit git-r3 autotools
else
    SRC_URI="https://github.com/solus-project/${PN}/releases/download/v${PV}/${P}.tar.xz -> ${P}.tar.xz"
    KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="
	>=dev-libs/glib-2.44.0
	>=x11-libs/gtk+-3.16.0:3
	>=dev-libs/libpeas-1.0[gtk]
	>=gnome-base/gnome-menus-3.10.1
	>=dev-libs/gobject-introspection-1.44.0
	>=media-sound/pulseaudio-4.0[glib]
	>=x11-wm/mutter-3.18.0
	>=gnome-base/gnome-desktop-3.18.0
	>=gnome-base/gsettings-desktop-schemas-3.18.0
	>=x11-libs/libwnck-3.14.0
	>=app-i18n/ibus-1.5.13
	>=sys-power/upower-0.9.20[introspection]"

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
