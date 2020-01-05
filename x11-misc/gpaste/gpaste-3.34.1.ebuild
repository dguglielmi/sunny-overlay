# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION="0.42"
VALA_USE_DEPEND="vapigen"

inherit autotools eutils gnome2-utils vala vcs-snapshot

DESCRIPTION="Clipboard management system"
HOMEPAGE="https://github.com/Keruspe/GPaste"
SRC_URI="https://github.com/Keruspe/GPaste/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="X bash-completion gnome vala zsh-completion"

CDEPEND="dev-libs/appstream-glib
	>=dev-libs/gjs-1.54.0
	>=dev-libs/glib-2.58:2
	>=dev-libs/gobject-introspection-1.58.0
	sys-apps/dbus
	>=x11-libs/gdk-pixbuf-2.38:2
	>=x11-libs/gtk+-3.24:3
	X? (
		x11-libs/libX11
		x11-libs/libXi
	)
	gnome? (
		gnome-base/gnome-control-center:2
		media-libs/clutter
		x11-libs/pango
		>=x11-wm/mutter-3.34.0:0/5
	)"
RDEPEND="${CDEPEND}
	gnome? ( gnome-base/gnome-shell )"
DEPEND="${CDEPEND}
	virtual/pkgconfig
	vala? ( $(vala_depend) )"

src_prepare() {
	default
	eautoreconf
	vala_src_prepare

	if ! use gnome ; then
		echo "" > data/control-center.mk || die
	fi
}

src_configure() {
	econf \
		$(use_enable X x-keybinder) \
		$(use_enable bash-completion) \
		$(use_enable vala) \
		$(use_enable gnome gnome-shell-extension) \
		$(use_enable zsh-completion) \
		--disable-static \
		--disable-schemas-compile
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
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
