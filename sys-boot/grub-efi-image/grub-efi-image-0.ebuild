# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit mount-boot

DESCRIPTION="Make GRUB EFI boot image"
HOMEPAGE="https://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"

IUSE="+grub_platforms_efi-64 grub_platforms_efi-32 grub_font_size_24 grub_font_size_32"

DEPEND="
	sys-boot/grub:2=[fonts]
"
RDEPEND="${DEPEND}"
BDEPEND="
	sys-apps/util-linux
	media-fonts/dejavu
"

GRUB_VERSION="2.06-r4"
EFI_VENDOR="gentoo"
GRUB_FONT_SIZE="16"

S="${WORKDIR}"

src_prepare() {
	# grub-probe --target=fs_uuid doesn't work here
	BOOT_DEV="$(grub-probe --target=device ${ROOT}/boot)"
	BOOT_PART_UUID="$(lsblk -o UUID -n ${BOOT_DEV})"

	[[ -z $BOOT_PART_UUID ]] && die "Can't find /boot partition UUID"
	sed -e 's#@GENTOO_GRUB_VERSION@#'${GRUB_VERSION}'#g' \
		"${FILESDIR}/sbat.csv.in" > sbat.csv || die

	mkdir -p "${WORKDIR}/memdisk/fonts" || die
	sed -e 's#@BOOT_PART_UUID@#'${BOOT_PART_UUID}'#g' \
		"${FILESDIR}/grub-memdisk.cfg.in" > memdisk/grub.cfg || die

	cp "${FILESDIR}/grub-bootstrap.cfg" "${WORKDIR}/"

	eapply_user
}

src_compile() {
	local plateform
	local efi_name

	if use grub_platforms_efi-64; then
		platform="x86_64-efi"
		efi_name="x64"
	elif use grub_platforms_efi-32; then
		platform="i386-efi"
		efi_name="x32"
	else
		die "Unsupported platform"
	fi

	if use grub_font_size_24; then
		GRUB_FONT_SIZE="24"
	elif use grub_font_size_32; then
		GRUB_FONT_SIZE="32"
	fi

	grub-mkfont \
		-s "${GRUB_FONT_SIZE}" \
		-o "${WORKDIR}/memdisk/fonts/unicode.pf2" \
		/usr/share/fonts/dejavu/DejaVuSansMono.ttf

	tar -cf "${WORKDIR}/memdisk.tar" -C "${WORKDIR}/memdisk" .


	grub-mkimage \
		-O "${platform}" \
		-o "${WORKDIR}/grub${efi_name}.efi" \
		-c "${WORKDIR}/grub-bootstrap.cfg" \
		-d "/usr/lib/grub/${platform}" \
		-m "${WORKDIR}/memdisk.tar" \
		-p "/EFI/gentoo" \
		--sbat "${WORKDIR}/sbat.csv" \
		$(cat "${FILESDIR}/grub-efi-modules")
}

src_install() {
	insinto /usr/lib/${PN}
	doins grub*.efi
}
