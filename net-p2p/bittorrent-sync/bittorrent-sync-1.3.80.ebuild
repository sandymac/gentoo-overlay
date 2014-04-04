# Copyright (C) 2013-2014 Jonathan Vasquez <fearedbliss@funtoo.org>
# Copyright (C) 2014 Sandy McArthur <Sandy@McArthur.org>
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit eutils user
NAME="btsync"
DESCRIPTION="Magic folder style file syncing powered by BitTorrent."
HOMEPAGE="http://www.bittorrent.com/sync"
SRC_URI="
	amd64?	( http://syncapp.bittorrent.com/${PV}/${NAME}_x64-${PV}.tar.gz )
	x86?	( http://syncapp.bittorrent.com/${PV}/${NAME}_i386-${PV}.tar.gz )
	ppc?    ( http://syncapp.bittorrent.com/${PV}/${NAME}_powerpc-${PV}.tar.gz )
	arm?    ( http://syncapp.bittorrent.com/${PV}/${NAME}_arm-${PV}.tar.gz ) "

RESTRICT="mirror strip"
LICENSE="BitTorrent"
SLOT="0"
KEYWORDS="amd64 x86 arm ppc"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

QA_PREBUILT="opt/btsync/btsync"

S="${WORKDIR}"

pkg_setup() {
	enewgroup btsync
	enewuser btsync -1 -1 -1 "btsync" --system
}

src_install() {
	einfo dodir "/opt/${NAME}"
	dodir "/opt/${NAME}"
	exeinto "/opt/${NAME}"
	doexe btsync
	insinto "/opt/${NAME}"
	doins LICENSE.TXT

	einfo dodir "/etc/init.d"
	dodir "/etc/init.d"
	insinto "/etc/init.d"
	doins "${FILESDIR}/init.d/${NAME}"
	fperms 755 /etc/init.d/btsync

	einfo dodir "/etc/conf.d"
	dodir "/etc/conf.d"
	insinto "/etc/conf.d"
	doins "${FILESDIR}/conf.d/${NAME}"

	einfo dodir "/etc/${NAME}"
	dodir "/etc/${NAME}"
	"${D}/opt/btsync/btsync" --dump-sample-config > "${D}/etc/${NAME}/config"
	sed -i 's|// "pid_file"|   "pid_file"|' "${D}/etc/${NAME}/config"
	fowners btsync "/etc/${NAME}/config"
	fperms 460 "/etc/${NAME}/config"
}

pkg_preinst() {
	# Customize for local machine
	# Set device name to `hostname`
	sed -i "s/My Sync Device/$(hostname) Gentoo Linux/"  "${D}/etc/btsync/config"
	# Update defaults to the btsync's home dir
	sed -i "s|/home/user|$(egethome btsync)|"  "${D}/etc/btsync/config"
}

pkg_postinst() {
	elog "Init scripts launch btsync daemon as btsync:btsync "
	elog "Please review/tweak /etc/${NAME}/config for default configuration."
	elog "Default web-gui URL is http://localhost:8888/ ."
}
