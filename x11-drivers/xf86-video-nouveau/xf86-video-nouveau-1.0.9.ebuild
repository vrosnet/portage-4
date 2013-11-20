# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-nouveau/xf86-video-nouveau-1.0.9.ebuild,v 1.6 2013/10/08 05:06:22 ago Exp $

EAPI=5
XORG_DRI="always"
inherit xorg-2

if [[ ${PV} == 9999* ]]; then
	EGIT_REPO_URI="git://anongit.freedesktop.org/git/nouveau/${PN}"
	SRC_URI=""
fi

DESCRIPTION="Accelerated Open Source driver for nVidia cards"
HOMEPAGE="http://nouveau.freedesktop.org/"

KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

RDEPEND=">=x11-libs/libdrm-2.4.34[video_cards_nouveau]"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-immintrin-include.patch"
)