# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools systemd

DESCRIPTION="Streaming relay for v4l2loopback using GStreamer"
HOMEPAGE="https://git.launchpad.net/v4l2-relayd"
SRC_URI="
	https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/${PN}/${PV}-0ubuntu1/${PN}_${PV}.orig.tar.xz
		-> ${P}.tar.xz
"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

IUSE="+icamera"

DEPEND="
	dev-libs/glib:=
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
"
RDEPEND="
	${DEPEND}
	icamera? (
		media-plugins/gst-plugins-icamera
	)
	media-video/v4l2loopback
"

src_prepare() {
	eautoreconf

	if use icamera; then
		sed -i \
			-e '/^FORMAT=/s#.*#FORMAT=NV12#g' \
			-e '/^VIDEOSRC=/s#.*#VIDEOSRC="icamerasrc"#g' \
			-e '/^CARD_LABEL=/s#.*#CARD_LABEL="Intel MIPI Camera"#g' \
			data/etc/default/${PN} || die

		sed -i \
			-e 's#card_label="Virtual Camera"#card_label="Intel MIPI Camera"#g' \
			data/etc/modprobe.d/${PN}.conf || die
	fi

	default
}

src_configure() {
	econf \
	--with-systemdsystemunitdir="$(systemd_get_systemunitdir)"
}
