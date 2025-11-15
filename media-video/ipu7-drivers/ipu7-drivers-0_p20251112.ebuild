# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
IPU7_COMMIT_ID="fc335577f95bf6ca3afc706d1ceab8297db4f010"

inherit linux-mod-r1 toolchain-funcs

DESCRIPTION="Intel IPU7 MIPI camera kernel driver"
HOMEPAGE="https://github.com/intel/ipu7-drivers"

SRC_URI="https://github.com/intel/${PN}/archive/${IPU7_COMMIT_ID}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${IPU7_COMMIT_ID}"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"

CONFIG_CHECK="
	IPU_BRIDGE
	VIDEO_V4L2_I2C
"

pkg_setup() {
	linux-mod-r1_pkg_setup
	export KERNELRELEASE=${KV_FULL}
}

src_compile() {
	local modlist=(
		intel-ipu7=kernel/drivers/media/pci/intel/ipu7::drivers/media/pci/intel/ipu7
		intel-ipu7-isys=kernel/drivers/media/pci/intel/ipu7::drivers/media/pci/intel/ipu7
		intel-ipu7-psys=kernel/drivers/media/pci/intel/ipu7/psys::drivers/media/pci/intel/ipu7/psys
		ipu-acpi=kernel/drivers/media/platform/intel::drivers/media/platform/intel
		ipu-acpi-common=kernel/drivers/media/platform/intel::drivers/media/platform/intel
		ipu-acpi-pdata=kernel/drivers/media/platform/intel::drivers/media/platform/intel
	)

	linux-mod-r1_src_compile
}
