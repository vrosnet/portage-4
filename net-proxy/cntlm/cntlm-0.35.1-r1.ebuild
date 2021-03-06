# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/cntlm/cntlm-0.35.1-r1.ebuild,v 1.2 2014/01/08 06:23:51 vapier Exp $

EAPI=2

inherit eutils user

DESCRIPTION="Cntlm is an NTLM/NTLMv2 authenticating HTTP proxy"
HOMEPAGE="http://cntlm.sourceforge.net/"
SRC_URI="mirror://sourceforge/cntlm/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_configure() {
	econf || die "econf failed"

	# Replace default config file path in Makefile
	sed -i -e 's~SYSCONFDIR=/usr/local/etc~SYSCONFDIR=/etc~' \
				"${S}"/Makefile || die "sed failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin cntlm
	dodoc COPYRIGHT README VERSION doc/cntlm.conf
	doman doc/cntlm.1
	newinitd "${FILESDIR}"/cntlm.initd cntlm
	newconfd "${FILESDIR}"/cntlm.confd cntlm
	insinto /etc
	insopts -m0600
	doins doc/cntlm.conf
}

pkg_postinst() {
	enewgroup cntlm
	enewuser cntlm -1 -1 -1 cntlm
}
