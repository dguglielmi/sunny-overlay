# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils linux-mod rpm

DESCRIPTION="Hercules DJ devices kernel module driver"
HOMEPAGE="ftp://ftp.hercules.com/pub/webupdate/DJCSeries"
SRC_URI="ftp://ftp.hercules.com/pub/webupdate/DJCSeries/Hercules_DJSeries_Linux.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-kernel/linux-headers"
RDEPEND="${DEPEND}"

pkg_setup() {
	linux-mod_pkg_setup
	CONFIG_CHECK="
		SND_RAWMIDI
		SND_VIRMIDI
		USB
	"
	check_extra_config
	BUILD_TARGETS="clean modules"
	BUILD_PARAMS="KERNELDIR=${KV_DIR}"
	MODULE_NAMES="hdj_mod()"
}

src_unpack() {
	unpack ${A}
	rpm_unpack "./kernel module/${PN}-dkms-${PV}-1.noarch.rpm"

	einfo "Move ${WORKDIR}/usr/src/${P} to ${S}"
	mv "${WORKDIR}/usr/src/${P}" "${S}"
}

src_prepare() {
	epatch "${FILESDIR}/dj_console_mp3_e2.patch"
	epatch "${FILESDIR}/${PN}_fix_hotplug.patch"
	epatch "${FILESDIR}/${PN}_kfree.patch"
	epatch "${FILESDIR}/${PN}_kernel_2.6.30.patch"
	epatch "${FILESDIR}/${PN}_kernel_2.6.36.patch"
	epatch "${FILESDIR}/${PN}_kernel_2.6.37.patch"
	epatch "${FILESDIR}/${PN}_kernel_2.6.39.patch"
	epatch "${FILESDIR}/${PN}_kernel_3.6.patch"
	epatch "${FILESDIR}/${PN}_kernel_3.7.patch"
	epatch "${FILESDIR}/${PN}_kernel_3.16.patch"
}
