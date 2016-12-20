# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit oasis

OASIS_BUILD_DOCS=1
DESCRIPTION="FUSE filesystem over Google Drive"
HOMEPAGE="http://forge.ocamlcore.org/projects/gdfuse"
SRC_URI="https://github.com/astrada/${PN}/archive/v${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc test"

RDEPEND=">=dev-ml/ocurl-0.5.3:=
	>=dev-ml/ocamlnet-3.3.5:=
	>=dev-ml/cryptokit-1.3.14:=
	>=dev-ml/extlib-1.5.1:=
	dev-ml/yojson
	dev-ml/xmlm
	>=dev-ml/gapi-ocaml-0.2.5
	dev-ml/ocamlfuse
	dev-ml/ocaml-sqlite3"
DEPEND="${RDEPEND}
	test? ( >=dev-ml/ounit-1.1.0 )"
DOCS=( "README.md" )
