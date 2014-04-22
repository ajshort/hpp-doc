#                                                                -*-Automake-*-
# Copyright (C) 2009 by Thomas Moulard, AIST, CNRS, INRIA.
# This file is part of the roboptim.
#
# roboptim is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Additional permission under section 7 of the GNU General Public
# License, version 3 ("GPLv3"):
#
# If you convey this file as part of a work that contains a
# configuration script generated by Autoconf, you may do so under
# terms of your choice.
#
# roboptim is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with roboptim.  If not, see <http://www.gnu.org/licenses/>.

# ------ #
# README #
# ------ #
#
# This mk file contains a rule for release announcement generation.
#
# To use this file, you must include first ``init.mk'' in your
# local ``Makefile.am''.
#
# It also requires that ``make dist'' produces a ``.tar.gz'' file.


# Distributed files.
EXTRA_DIST += 						\
	$(top_srcdir)/build-aux/announce-gen

IS_MAJOR=$$(echo '@PACKAGE_VERSION@'			\
	| $(GREP) '^[:digit:]+\.[:digit:]+(\.[:digit:]+)$$')

RELEASE_TYPE=$$(if test x = x$(IS_MAJOR); then echo alpha; else echo major; fi)

announce-mail: $(distdir).tar.gz
	$(top_srcdir)/build-aux/announce-gen				\
		--release-type=$(RELEASE_TYPE)				\
		--package-name='@PACKAGE_TARNAME@'			\
		--current-version='@PACKAGE_VERSION@'			\
		--url-directory='http://dl.sourceforge.net/$(SF_PROJECT_ID)'\
		--news=$(srcdir)/NEWS					\
		--bootstrap-tools=autoconf,automake,libtool		\
		--previous-version='FIXME'				\
		--gpg-key-id='FIXME'					\
	| tee "$@"