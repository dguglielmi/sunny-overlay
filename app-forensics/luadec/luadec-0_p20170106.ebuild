# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
LUA_COMPAT=( lua5-1 )
LUA_TARGET=5.1.5
EGIT_COMMIT="895d92313fabaee260121c758c8320d1b21dd741"

inherit lua-single

DESCRIPTION="LuaDec is a Lua decompiler for lua 5.1"
HOMEPAGE="https://github.com/viruscamp/luadec"
SRC_URI="https://github.com/viruscamp/luadec/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz
	https://www.lua.org/ftp/lua-${LUA_TARGET}.tar.gz"

LICENSE="MIT"
SLOT="5.1"
KEYWORDS="~amd64 ~x86"

REQUIRED_USE="${LUA_REQUIRED_USE}"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="${LUA_DEPS}"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

src_prepare() {
	rm -rf lua-${SLOT}
	ln -s ${WORKDIR}/lua-${LUA_TARGET} lua-${SLOT}

	default
}

src_compile() {
	emake -C lua-${SLOT} linux || die
	emake LUAVER=${SLOT} -C luadec || die
}

src_install() {
	for b in luadec luareplace luaopswap; do
		newbin luadec/${b} ${b}-${SLOT}
	done
}
