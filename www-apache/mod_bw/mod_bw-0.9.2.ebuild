# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_bw/mod_bw-0.9.2.ebuild,v 1.5 2014/08/10 20:14:51 slyfox Exp $

inherit apache-module

DESCRIPTION="Bandwidth Management Module for Apache2"
HOMEPAGE="http://www.ivn.cl/apache/"

SRC_URI="http://ivn.cl/files/source/${P/9./9}.tgz"

KEYWORDS="amd64 ppc x86"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

DEPEND="sys-devel/libtool"
RDEPEND=""

APACHE2_MOD_CONF="11_${PN}"
APACHE2_MOD_DEFINE="BW"

need_apache2_2

S="${WORKDIR}"
