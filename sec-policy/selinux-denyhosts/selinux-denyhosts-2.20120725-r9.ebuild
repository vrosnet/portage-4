# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-denyhosts/selinux-denyhosts-2.20120725-r9.ebuild,v 1.2 2013/01/13 16:03:45 swift Exp $
EAPI="4"

IUSE=""
MODS="denyhosts"
BASEPOL="2.20120725-r9"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for denyhosts"

KEYWORDS="amd64 x86"