# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ktnef/ktnef-4.13.3.ebuild,v 1.2 2014/08/05 18:17:16 mrueg Exp $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="A viewer for TNEF attachments"
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="LGPL-2.1"
IUSE="debug"

DEPEND="
	app-office/akonadi-server
	$(add_kdebase_dep kdepimlibs)
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	akonadi/
"
