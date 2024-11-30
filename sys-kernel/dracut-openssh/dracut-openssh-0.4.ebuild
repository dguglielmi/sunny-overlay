# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Dracut OpenSSH module"
HOMEPAGE="https://github.com/dguglielmi/dracut-openssh"
SRC_URI="https://github.com/dguglielmi/dracut-openssh/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="systemd systemd-networkd"

DEPEND="
	net-misc/openssh
	sys-kernel/dracut
"
RDEPEND="
	${DEPEND}
	!systemd-networkd? ( net-misc/dhcp )
	systemd? ( sys-apps/systemd )
"

src_install() {
	emake PREFIX="${D}" install

	if use systemd-networkd; then
	sed -i \
		's@^#network_provider=.*@network_provider="systemd-networkd"@1' \
		"${D}"/etc/dracut.conf.d/dracut-openssh.conf || die
	fi
}
