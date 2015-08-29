# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qmake-utils multilib

DESCRIPTION="Free and cross-platform software to control DMX or analog lighting systems"
HOMEPAGE="http://www.qlcplus.org"
SRC_URI="http://www.qlcplus.org/downloads/${PV}/${PN}_${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+fixtures-editor +httpd midi opendmx ola peperoni udmx"

LINGUAS="fr"

DEPEND="
	>=dev-qt/qtcore-4.6:4
	>=dev-qt/qtgui-4.6:4
	>=dev-qt/qttest-4.6:4
	>=media-libs/alsa-lib-1.0.23
	opendmx? ( >=dev-embedded/libftdi-0.17
		virtual/libusb:0 )
	ola? ( >=app-misc/ola-0.9.7 )
	peperoni? ( virtual/libusb:0 )
	udmx? ( virtual/libusb:0 )
"

RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}_fix-desktop-files.patch"

	sed -i -e 's#/etc/udev/rules\.d#'$(get_libdir)'/udev/rules.d#g' \
		plugins/dmxusb/src/src.pro \
		plugins/hid/hid.pro \
		plugins/spi/spi.pro \
		plugins/peperoni/unix/unix.pro \
		plugins/udmx/src/src.pro || die "Change udev rules path failed"

	sed -i -e '/^unix:!macx:LIBSDIR =/s#lib#'$(get_libdir)'#1' variables.pri || die

	if ! use fixtures-editor ; then
		sed -i -e '/SUBDIRS      += fixtureeditor/d' qlc.pro || die
		sed -i -e '/desktop.files/s# qlcplus-fixtureeditor.desktop##g' etc/etc.pro || die
		sed -i -e '/icons.files/s# ../resources/icons/png/qlcplus-fixtureeditor.png##g' etc/etc.pro || die
	fi

	if ! use httpd ; then
	sed -i -e '/SUBDIRS      += webaccess/d' qlc.pro || die
		sed -i -e '/INCLUDEPATH  += ..\/webaccess\/src/d' main/main.pro || die
		sed -i -e '/QMAKE_LIBDIR += ..\/webaccess\/src/d' main/main.pro || die
		sed -i -e '/LIBS         += -lqlcpluswebaccess/d' main/main.pro || die
		sed -i -e '/INCLUDEPATH     += ..\/..\/webaccess/d' ui/src/src.pro || die

		epatch "${FILESDIR}/${P}_remove-webaccess.patch"
	fi

	if ! use midi ; then
		sed -i -e '/SUBDIRS              += midi/d' plugins/plugins.pro || die
	fi

	if ! use opendmx ; then
		sed -i -e '/SUBDIRS              += dmxusb/d' plugins/plugins.pro || die
	fi

	if ! use ola ; then
		sed -i -e '/SUBDIRS              += ola/d' plugins/plugins.pro || die
	fi

	if ! use udmx ; then
		sed -i -e '/SUBDIRS              += udmx/d' plugins/plugins.pro || die
	fi

	if ! use peperoni ; then
		sed -i -e '/SUBDIRS              += peperoni/d' plugins/plugins.pro || die
	fi
}

src_configure() {
	eqmake4
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
