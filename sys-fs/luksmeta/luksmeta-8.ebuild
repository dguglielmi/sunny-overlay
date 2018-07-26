# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="LUKSMeta is a simple library for storing metadata in the LUKSv1 header"
HOMEPAGE="https://latchset.github.io/"
SRC_URI="https://github.com/latchset/${PN}/releases/download/v${PV}/${P}.tar.bz2"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-fs/cryptsetup"
RDEPEND="${DEPEND}"
