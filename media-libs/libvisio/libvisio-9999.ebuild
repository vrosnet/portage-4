# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libvisio/libvisio-9999.ebuild,v 1.20 2014/09/14 09:21:44 dilfridge Exp $

EAPI=5

EGIT_REPO_URI="git://anongit.freedesktop.org/git/libreoffice/libvisio/"
inherit base eutils
[[ ${PV} == 9999 ]] && inherit autotools git-2

DESCRIPTION="Library parsing the visio documents"
HOMEPAGE="https://wiki.documentfoundation.org/DLP/Libraries/libvisio"
[[ ${PV} == 9999 ]] || SRC_URI="http://dev-www.libreoffice.org/src/${PN}/${P}.tar.xz"

LICENSE="|| ( GPL-2+ LGPL-2.1 MPL-1.1 )"
SLOT="0"
[[ ${PV} == 9999 ]] || \
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE="doc static-libs"

RDEPEND="
	dev-libs/icu:=
	dev-libs/librevenge
	dev-libs/libxml2
	sys-libs/zlib
"
DEPEND="${RDEPEND}
	>=dev-libs/boost-1.46
	dev-util/gperf
	sys-devel/libtool
	virtual/pkgconfig
	doc? ( app-doc/doxygen )
"

src_prepare() {
	[[ -d m4 ]] || mkdir "m4"
	base_src_prepare
	[[ ${PV} == 9999 ]] && eautoreconf
}

src_configure() {
	econf \
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
		$(use_enable static-libs static) \
		--disable-werror \
		$(use_with doc docs)
}

src_install() {
	default
	prune_libtool_files --all
}
