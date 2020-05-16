# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Dracut OpenSSH module"
HOMEPAGE="https://github.com/dguglielmi/dracut-openssh"
SRC_URI="https://github.com/dguglielmi/dracut-openssh/archive/v0.3.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="systemd-networkd"

DEPEND="!systemd-networkd? ( net-misc/dhcp )
	net-misc/openssh
	sys-apps/systemd
	sys-kernel/dracut"
RDEPEND="${DEPEND}"

src_install() {
	emake PREFIX=${D} install

	if use systemd-networkd; then
	sed -i \
		's@^#network_provider=.*@network_provider="systemd-networkd"@1' \
		"${D}"/etc/dracut.conf.d/dracut-openssh.conf || die
	fi
}
