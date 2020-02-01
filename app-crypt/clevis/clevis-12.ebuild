# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson systemd

DESCRIPTION="Clevis is a plugable framework for automated decryption"
HOMEPAGE="https://latchset.github.io/"
SRC_URI="https://github.com/latchset/${PN}/releases/download/v${PV}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bash-completion dracut tpm2 udisks"

DEPEND="tpm2? ( app-crypt/tpm2-tools )
	app-text/asciidoc
	>=sys-fs/luksmeta-8
	dev-libs/openssl:0=
	>=dev-libs/jansson-2.10
	>=dev-libs/jose-8
	>=sys-fs/cryptsetup-2.0.4[pwquality]
	sys-apps/systemd
	dracut?	( sys-kernel/dracut )
	udisks? ( sys-fs/udisks:2 )
	>=sys-process/audit-2.7.8
	bash-completion? ( app-shells/bash-completion )"
RDEPEND="${DEPEND}"
