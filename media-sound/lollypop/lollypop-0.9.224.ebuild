# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python3_4 )
PYTHON_REQ_USE="sqlite"

inherit gnome2 python-single-r1

DESCRIPTION="Lollypop is a GNOME music playing application"
HOMEPAGE="http://gnumdk.github.io/lollypop/"
SRC_URI="https://github.com/gnumdk/lollypop/releases/download/${PV}/${P}.tar.xz"


LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+lastfm +wikipedia"

IUSE+=" +python_single_target_python3_4"

RDEPEND="${PYTHON_DEPS}
    >=x11-libs/gtk+-3.13.2:3[introspection]
    >=dev-libs/gobject-introspection-1.35.9
    dev-python/pygobject:3[cairo,${PYTHON_USEDEP}]                              
	dev-python/dbus-python[${PYTHON_USEDEP}]                                    
	media-libs/gstreamer:1.0[introspection] 
    >=dev-libs/totem-pl-parser-3.10.4
	x11-libs/libnotify[introspection]
    lastfm? ( >=dev-python/pylast-1.0.0 )
    wikipedia? ( >=dev-python/wikipedia-1.4.0 )
"
DEPEND="${RDEPEND}
    >=dev-util/intltool-0.26 
    dev-util/itstool
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_configure() {
    gnome2_src_configure ITSTOOL="$(type -P true)"
}

src_install() {
    gnome2_src_install
    python_fix_shebang "${ED}"
}
