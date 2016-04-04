# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit multilib

DESCRIPTION="PSP Shrink"
HOMEPAGE="http://code.google.com/p/pspshrink/"
SRC_URI="http://pspshrink.googlecode.com/files/${PF}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug multilib gtk"


#DEPEND="amd64? ( app-emulation/emul-linux-x86-baselibs )
DEPEND="gtk? ( dev-cpp/gtkmm )"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
}
