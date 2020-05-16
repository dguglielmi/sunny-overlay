# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Dracut OpenSSH module"
HOMEPAGE="https://github.com/dguglielmi/dracut-openssh"
SRC_URI=""

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="systemd-networkd"

DEPEND="!systemd-networkd? ( net-misc/dhcp )
	net-misc/openssh
	sys-apps/systemd
	sys-kernel/dracut"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
	dodir /usr/lib/dracut/modules.d/48openssh

	insinto /usr/lib/dracut/modules.d/48openssh
	doins "${FILESDIR}"/sshd_config
	doins "${FILESDIR}"/sshd.service

	exeinto /usr/lib/dracut/modules.d/48openssh
	doexe "${FILESDIR}/module-setup.sh"

	insinto /etc/dracut.conf.d
	doins "${FILESDIR}/dracut-openssh.conf"
}
