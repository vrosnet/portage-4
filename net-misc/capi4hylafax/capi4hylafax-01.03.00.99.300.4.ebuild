# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/capi4hylafax/capi4hylafax-01.03.00.99.300.4.ebuild,v 1.4 2011/02/26 21:49:22 signals Exp $

inherit eutils versionator autotools

FAX_SPOOL_DIR="/var/spool/fax"

MY_PV1="$(get_version_component_range 1-4)"
MY_PV2="$(get_version_component_range 5)"
MY_PV3="$(get_version_component_range 6)"
MY_P="${PN}_${MY_PV1}.svn.${MY_PV2}"

DESCRIPTION="capi4hylafax adds a faxcapi modem to the hylafax enviroment."
SRC_URI="mirror://debian/pool/main/c/capi4hylafax/${MY_P}.orig.tar.gz
		mirror://debian/pool/main/c/capi4hylafax/${MY_P}-${MY_PV3}.diff.gz"
HOMEPAGE="http://packages.qa.debian.org/c/capi4hylafax.html"

S="${WORKDIR}/${PN}-svn"

IUSE="unicode"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="net-dialup/capi4k-utils
	media-libs/tiff
	virtual/jpeg
	sys-libs/zlib"

RDEPEND="${DEPEND}
	dev-util/dialog"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# apply debian patches + update configs
	epatch "${WORKDIR}/${MY_P}-${MY_PV3}.diff"

	# update autotools
	eautoreconf

	# fix location of fax spool
	for i in config.faxCAPI Readme_src src/defaults.h.in debian/*.1; do
		[ -f "${i}" ] && sed -i -e "s:/var/spool/hylafax:${FAX_SPOOL_DIR}:g" "${i}"
	done

	# fix location of fax config
	sed -i -e "s:/etc/hylafax:${FAX_SPOOL_DIR}/etc:g" setupconffile

	# fix name and location of logfile
	sed -i -e "s:/var/spool/fax/log/capi4hylafax:/var/log/${PN}.log:" config.faxCAPI
	sed -i -e "s:/tmp/capifax.log:/var/log/${PN}.log:" src/defaults.h.in config.faxCAPI

	# patch man pages
	sed -i -e "s:/usr/share/doc/capi4hylafax/:/usr/share/doc/${PF}/html/:g" \
		-e "s:c2send:c2faxsend:g" -e "s:c2recv:c2faxrecv:g" \
		-e "s:CAPI4HYLAFAXCONFIG \"1\":C2FAXADDMODEM \"8\":g" \
		-e "s:capi4hylafaxconfig:c2faxaddmodem:g" debian/*.1
	cp -f debian/capi4hylafaxconfig.1 debian/c2faxaddmodem.8

	# if specified, convert all relevant files from latin1 to UTF-8
	if use unicode; then
		for i in config.faxCAPI; do
			einfo "Converting ${i} to UTF-8"
			iconv -f latin1 -t utf8 -o "${i}~" "${i}" && mv -f "${i}~" "${i}" || rm -f "${i}~"
		done
	fi
}

src_compile() {
	econf --with-hylafax-spooldir="${FAX_SPOOL_DIR}" || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	keepdir "${FAX_SPOOL_DIR}"/{etc,recvq,pollq,log,status}
	fowners uucp:uucp "${FAX_SPOOL_DIR}" "${FAX_SPOOL_DIR}"/{etc,recvq,pollq,log,status}
	fperms 0700 "${FAX_SPOOL_DIR}"

	make DESTDIR="${D}" install || die "make install failed"

	# install setup script
	newsbin setupconffile c2faxaddmodem

	# install sample config
	insinto "${FAX_SPOOL_DIR}/etc"
	newins config.faxCAPI config.faxCAPI.default

	# install docs
	dodoc AUTHORS ChangeLog Readme_src
	newdoc debian/changelog ChangeLog.debian
	dohtml README.html LIESMICH.html

	# install man pages
	doman debian/c2fax*.[18]

	# install examples
	insinto /usr/share/doc/${PF}/examples
	doins sample_faxrcvd faxrcvd config.faxCAPI fritz_pic.tif GenerateFileMail.pl
	newins sample_AVMC4_config.faxCAPI config.faxCAPI_AVMC4
	newins debian/faxsend sample_faxsend

	# finally install init-script + config
	newinitd "${FILESDIR}/${PN}.initd" ${PN}
	newconfd "${FILESDIR}/${PN}.confd" ${PN}
}

pkg_postinst() {
	einfo "To use capi4hylafax:"
	einfo "Make sure that your isdn/capi devices are owned by"
	einfo "the \"uucp\" user (see udev or devfsd config)."
	einfo "Modify ${FAX_SPOOL_DIR}/etc/config.faxCAPI"
	einfo "to suit your system."

	if [ -f "${FAX_SPOOL_DIR}/etc/config.faxCAPI" ]; then
		einfo
		einfo "If you're upgrading from a previous version"
		einfo "please check for new or changed options."
		einfo "A sample default config is installed as:"
		einfo "${FAX_SPOOL_DIR}/etc/config.faxCAPI.default"
	else
		# install default config
		cp -f "${FAX_SPOOL_DIR}/etc/config.faxCAPI.default" \
			"${FAX_SPOOL_DIR}/etc/config.faxCAPI"
	fi

	einfo
	einfo "You should also check special options in:"
	einfo "/etc/conf.d/${PN}"
	einfo
	einfo "If you want to use capi4hylafax together with"
	einfo "hylafax, then please emerge net-misc/hylafax"
	einfo
	einfo "Then append the following line to your hylafax"
	einfo "config file (${FAX_SPOOL_DIR}/etc/config):"
	einfo "SendFaxCmd:             /usr/bin/c2faxsend"
}