# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )
VALA_MIN_API_VERSION=0.20
VALA_USE_DEPEND=vapigen

inherit vala autotools python-r1

DESCRIPTION="BAMF Application Matching Framework"
HOMEPAGE="https://launchpad.net/bamf"
SRC_URI="http://launchpad.net/${PN}/0.5/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+introspection doc static-libs"

RDEPEND="dev-libs/dbus-glib
	dev-util/gdbus-codegen
	dev-libs/glib:2
	gnome-base/libgtop:2
	x11-libs/gtk+:3
	x11-libs/libX11
	>=x11-libs/libwnck-3.4.7:3"
DEPEND="${RDEPEND}
	$(vala_depend)
	${PYTHON_DEPS}
	dev-libs/libxml2[python]
	dev-libs/libxslt[python]
	introspection? ( dev-libs/gobject-introspection )"
BDEPEND="virtual/pkgconfig"

DOCS=(AUTHORS COPYING COPYING.LGPL ChangeLog NEWS README TODO)

src_prepare() {
	if use introspection; then
		vala_src_prepare
		export VALA_API_GEN="${VAPIGEN}"
	fi

	eautoreconf
	default
}

src_configure() {
	python_setup
	econf $(use_enable introspection )
}
