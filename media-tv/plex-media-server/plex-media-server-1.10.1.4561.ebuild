# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils unpacker user
MAGIC="9de2951fc"
URI_PRE="http://downloads.plexapp.com/plex-media-server/${PV}-${MAGIC}/plexmediaserver_${PV}-${MAGIC}_"

DESCRIPTION="Plex Media Server is a free media library that is intended for use with a plex client available for OS X, iOS and Android systems. It is a standalone product which can be used in conjunction with every program, that knows the API. For managing the library a web based interface is provided."
HOMEPAGE="https://plex.tv/"
KEYWORDS="-* ~x86 ~amd64"
SRC_URI="x86? ( ${URI_PRE}i386.deb )
	amd64?  ( ${URI_PRE}amd64.deb )"
SLOT="0"
LICENSE="PMS-License"
IUSE=""
RESTRICT="mirror bindist strip"

RDEPEND="net-dns/avahi"
DEPEND="${RDEPEND}"

QA_PREBUILT="*"

INIT_SCRIPT="${ROOT}/etc/init.d/plex-media-server"

pkg_setup() {
	enewgroup plex
	enewuser plex -1 /bin/bash /var/lib/plexmediaserver "plex" --system
}

src_prepare() {
	einfo "cleaning apt config entry"
	rm -r etc/apt
	rm -r etc/init
	rm -r etc/init.d/plexmediaserver

	einfo "updating init script"
	cp "${FILESDIR}"/pms_initd_1 etc/init.d/plex-media-server
	chmod 755 etc/init.d/plex-media-server

	einfo "moving config files"
	# move the config to the correct place
	mkdir etc/plex
	mv etc/default/plexmediaserver etc/plex/plexmediaserver.conf
	rmdir etc/default

	einfo "patching startup"
	# apply patch for start_pms to use the new config file
	cd usr/sbin
	epatch "${FILESDIR}"/start_pms_1.patch
	cd ../..
	# remove debian specific useless files
	rm usr/share/doc/plexmediaserver/README.Debian
}

src_configure() {
	einfo "preparing logging targets"
	mkdir -p var/log/pms
	keepdir var/log/pms

	einfo "prepare default library destination"
	# also make sure the default library folder is pre created with correct permissions
	mkdir -p var/lib/plexmediaserver
	keepdir var/lib/plexmediaserver

	# Fix some QA warnings
	sed -i 's/^Categories=/Categories=AudioVideo;/' usr/share/applications/plexmediamanager.desktop || die 'sed failed on plexmediamanager.desktop'
	sed -i 's/;Media;/;X-Media;/' usr/share/applications/plexmediamanager.desktop || die 'sed failed on plexmediamanager.desktop'
}

src_install() {
	cp -a * "${D}"
	chown plex:plex "${D}/var/log/pms"
	chown plex:plex "${D}/var/lib/plexmediaserver"
}

pkg_preinst() {
	einfo "Stopping running instances of Media Server"
	if [ -e "${INIT_SCRIPT}" ]; then
		${INIT_SCRIPT} stop
	fi
}

pkg_prerm() {
	einfo "Stopping running instances of Media Server"
	if [ -e "${INIT_SCRIPT}" ]; then
	    ${INIT_SCRIPT} stop
	fi
}

pkg_postinst() {
	einfo ""
	elog "Plex Media Server is now fully installed. Please check the configuration file in /etc/plex if the defaults please your needs."
	elog "To start please call '/etc/init.d/plex-media-server start'. You can manage your library afterwards by navigating to http://<ip>:32400/web/"
	einfo ""

	ewarn "Please note, that the URL to the library management has changed from http://<ip>:32400/manage to http://<ip>:32400/web!"
	ewarn "If the new management interface forces you to log into myPlex and afterwards gives you an error that you need to be a plex-pass subscriber please delete the folder WebClient.bundle inside the Plug-Ins folder found in your library!"
}
