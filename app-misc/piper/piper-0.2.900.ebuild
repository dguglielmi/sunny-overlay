# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6} )

inherit gnome2 meson python-r1

DESCRIPTION="GTK application to configure gaming mice"
HOMEPAGE="https://github.com/libratbag/piper"
SRC_URI="https://github.com/libratbag/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	virtual/pkgconfig
	dev-python/pygobject:3
	>=x11-libs/gtk+-3.22:3[introspection]
"
RDEPEND="
	dev-libs/libratbag
	dev-python/python-evdev[${PYTHON_USEDEP}]
"

PATCHES=(
	${FILESDIR}/${P}-add-hr.po.patch
	${FILESDIR}/${P}-update-hr.po.patch
	${FILESDIR}/${P}-mousemap-redraw-on-allocate.patch
	${FILESDIR}/${P}-buttondialog-correctly-re-initialize-the-current-mac.patch
	${FILESDIR}/${P}-ratbagdprofile-emit-notify-is-active-from-dbus-prope.patch
	${FILESDIR}/${P}-ratbagdresolution-cache-the-is_active-property-to-si.patch
	${FILESDIR}/${P}-ratbagdresolution-cache-the-is_default-property-to-s.patch
	${FILESDIR}/${P}-piper-ratbagd.py-sync-with-libratbag.patch
	${FILESDIR}/${P}-ratbagd-sync-with-libratbag.patch
	${FILESDIR}/${P}-add-sv-l10n.patch
	${FILESDIR}/${P}-ratbagd-sync-with-libratbag.patch-1.patch
	${FILESDIR}/${P}-devicerow-don-t-overwrite-device-with-the-svg.patch
	${FILESDIR}/${P}-resolutionspage-fix-bad-toggles-of-report-rate.patch
	${FILESDIR}/${P}-update-polish-translation.patch
	${FILESDIR}/${P}-ratbagd-sync-with-libratbag.patch-2.patch
	${FILESDIR}/${P}-ratbagdled-fix-docstring.patch
	${FILESDIR}/${P}-resolutionrow-use-new-ratbagdresolution-api.patch
	${FILESDIR}/${P}-do-not-generate-icon-cache-when-destdir-is-set.patch
	${FILESDIR}/${P}-sync-led-type-from-libratbag.patch
	${FILESDIR}/${P}-resolutionsrow-snap-to-nearest-allowed-resolution-va.patch
	${FILESDIR}/${P}-led-add-an-image-for-the-led-off-page.patch
	${FILESDIR}/${P}-mousemap-if-the-old-highlight-is-none-don-t-try-to-r.patch
	${FILESDIR}/${P}-leddialog-use-new-effect-duration-in-ms.patch
	${FILESDIR}/${P}-ratbagd.py-sync-with-libratbag.patch
	${FILESDIR}/${P}-hide-led-modes-that-are-not-supported.patch
)

src_prepare() {
    python_setup
	default
}

src_configure() {
	meson_src_configure
}
