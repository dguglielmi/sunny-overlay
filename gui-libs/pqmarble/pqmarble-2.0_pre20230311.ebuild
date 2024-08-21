# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson vala

COMMIT_ID="f240b2ec7d5cdacb8fdcc553703420dc5101ffdb"

DESCRIPTION="PQMarble is a utility library for GNOME apps"
HOMEPAGE="https://gitlab.gnome.org/raggesilver/marble"

SRC_URI="
	https://gitlab.gnome.org/raggesilver/marble/-/archive/${COMMIT_ID}/marble-${COMMIT_ID::-30}.tar.bz2
		-> ${P}.tar.bz2
"

S="${WORKDIR}/${PN/pq}-${COMMIT_ID}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	>=gui-libs/gtk-4.12.0:4
"
RDEPEND="${DEPEND}"
BDEPEND="
	${DEPEND}
"

src_prepare() {
	vala_setup
	default
}

src_configure() {
	local emesonargs=(
		-Dtests=false # There is no tests yet
	)
	meson_src_configure
}
