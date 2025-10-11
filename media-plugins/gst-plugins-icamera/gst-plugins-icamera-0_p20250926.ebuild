# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

COMMIT_ID="4fb31db76b618aae72184c59314b839dedb42689"

DESCRIPTION="icamera plugin for GStreamer"
HOMEPAGE="https://github.com/intel/icamerasrc/tree/icamerasrc_slim_api"

SRC_URI="https://github.com/intel/icamerasrc/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}//icamerasrc-${COMMIT_ID}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-bad:1.0
	media-libs/ipu7-camera-bins
	media-libs/ipu7-camera-hal
	media-libs/libva
	x11-libs/libdrm[video_cards_intel]
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	default

	eautoreconf
}

src_configure() {
	export CHROME_SLIM_CAMHAL=ON
	econf --enable-gstdrmformat=yes
}

src_install() {
	default

	find "${D}" -name '*.la' -delete || die
}
