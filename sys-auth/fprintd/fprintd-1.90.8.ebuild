# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson pam systemd

DESCRIPTION="D-Bus service to access fingerprint readers"
HOMEPAGE="https://gitlab.freedesktop.org/libfprint/fprintd"
SRC_URI="https://gitlab.freedesktop.org/libfprint/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc pam"

RDEPEND="
	dev-libs/dbus-glib
	dev-libs/glib:2
	|| ( >=sys-auth/libfprint-1.90.1 >=sys-auth/libfprint-tod-1.90.1 )
	sys-auth/polkit
	pam? ( sys-libs/pam )
"
DEPEND="${RDEPEND}
	dev-python/dbusmock
	dev-util/gtk-doc
	dev-util/gtk-doc-am
	dev-util/intltool
	doc? ( dev-libs/libxml2 dev-libs/libxslt )
	pam? ( sys-libs/pam_wrapper )
"

S="${WORKDIR}/${PN}-v${PV}"

src_configure() {
	local emesonargs=(
		$(meson_use pam)
		$(meson_use doc gtk_doc)
		-Dsystemd=true
		-Dpam_modules_dir="$(getpam_mod_dir)"
		-Dsystemd_system_unit_dir="$(systemd_get_systemunitdir)"
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	keepdir /var/lib/fprint

	find "${D}" -name "*.la" -delete || die

	dodoc AUTHORS NEWS README{,.transifex} TODO
	newdoc pam/README README.pam_fprintd
	if use doc ; then
		insinto /usr/share/doc/${PF}/html
		doins ${BUILD_DIR}/doc/{fprintd-docs,version}.xml
		insinto /usr/share/doc/${PF}/html/dbus
		doins ${BUILD_DIR}/doc/dbus/net.reactivated.Fprint.{Device,Manager}.ref.xml
	fi
}

pkg_postinst() {
	elog "Please take a look at README.pam_fprintd for integration docs."
}
