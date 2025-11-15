# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
COMMIT_ID="a8d772f261bc90376944956b7bfd49b325ffa2f2"

inherit linux-mod-r1 toolchain-funcs

DESCRIPTION="Intel Vision Driver for Intel Lunar Lake (LNL) CVS-enabled Platforms"
HOMEPAGE="https://github.com/intel/vision-drivers"

SRC_URI="https://github.com/intel/${PN}/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT_ID}"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"

CONFIG_CHECK="
	GPIO_LJCA
"

pkg_setup() {
	linux-mod-r1_pkg_setup
	export KERNELRELEASE=${KV_FULL}
}

src_compile() {
	local modlist=(
		intel_cvs=kernel/drivers/misc:::all
	)

	linux-mod-r1_src_compile
}
