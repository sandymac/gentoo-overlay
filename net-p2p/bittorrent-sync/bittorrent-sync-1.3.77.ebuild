# Copyright (C) 2013-2014 Jonathan Vasquez <fearedbliss@funtoo.org>
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

NAME="btsync"
DESCRIPTION="Magic folder style file syncing."
HOMEPAGE="http://www.bittorrent.com/sync"
SRC_URI="
	amd64?	( http://syncapp.bittorrent.com/${PV}/btsync_x64-${PV}.tar.gz )
	x86?	( http://syncapp.bittorrent.com/${PV}/btsync_i386-${PV}.tar.gz )"

RESTRICT="mirror strip"
LICENSE="BitTorrent"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

QA_PREBUILT="opt/btsync/btsync"

S="${WORKDIR}"

src_install() {
	mkdir -p ${D}/opt/${NAME} && cd ${D}/opt/${NAME}
	mkdir -p ${D}/etc/{init.d,conf.d,${NAME}}

	cp ${S}/btsync .
	cp ${S}/LICENSE.TXT .
	./btsync --dump-sample-config > ${D}/etc/${NAME}/config
	cp ${FILESDIR}/init.d/${NAME} ${D}/etc/init.d/
	cp ${FILESDIR}/conf.d/${NAME} ${D}/etc/conf.d/

	# Set more secure permissions
	chmod 755 ${D}/etc/init.d/btsync
}

pkg_preinst() {
	# Customize for local machine
	sed -i "s/My Sync Device/$(hostname)/"  "${D}/etc/btsync/config"
}
