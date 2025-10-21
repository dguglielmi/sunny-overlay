# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
COMMIT_ID="774890f017eaa000df0647965a627f8738dcea71"

inherit linux-mod-r1 toolchain-funcs

DESCRIPTION="USBIO drivers for Meteor Lake, Arrow Lake, Lunar Lake and Panther Lake platforms"
HOMEPAGE="https://github.com/intel/usbio-drivers"

SRC_URI="https://github.com/intel/${PN}/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT_ID}"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"

pkg_setup() {
	linux-mod-r1_pkg_setup
	export KERNELRELEASE=${KV_FULL}
}

src_compile() {
	local modlist=(
		usbio=kernel/drivers/misc:::all
		gpio-usbio=kernel/drivers/misc:::all
		i2c-usbio=kernel/drivers/misc:::all
	)

	linux-mod-r1_src_compile
}
