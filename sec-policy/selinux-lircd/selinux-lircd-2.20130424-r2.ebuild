# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-lircd/selinux-lircd-2.20130424-r2.ebuild,v 1.2 2013/08/15 07:00:23 swift Exp $
EAPI="4"

IUSE=""
MODS="lircd"
BASEPOL="2.20130424-r2"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for lircd"

KEYWORDS="amd64 x86"