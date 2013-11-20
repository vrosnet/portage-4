# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/leechcraft-pogooglue/leechcraft-pogooglue-0.5.90.ebuild,v 1.3 2013/02/16 21:33:45 ago Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Provides searching with Google to other LeechCraft plugins"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="~net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}"