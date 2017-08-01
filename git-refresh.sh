#!/bin/bash
# ----------------------------------------------------------------------
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# ----------------------------------------------------------------------

### includes
SCRIPTDIR="$(dirname ${0})"

# do color output if COLORTERM is set, if colsh_definitions.inc is not
# included, cecho just outputs without color
if [ "${COLORTERM}" = 'yes' ]
then
	. "${SCRIPTDIR}/colsh/colsh_definitions.inc"
fi
. "${SCRIPTDIR}/colsh/colsh_cecho.inc"

# git
. "${SCRIPTDIR}/git/git-sh-setup.sh"

### main
GIT_CURRENT_BRANCH="$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)"

if [ ! "${GIT_CURRENT_BRANCH}" = 'master' ]
then
	cecho --warn 'Not on master, aborting …'
	exit 1
fi

require_clean_work_tree refresh

cecho --info '$ git pull'
git pull || exit 2

cecho --info '$ git remote update'
git remote update || exit 3

cecho --info '$ git merge upstream/master'
git merge upstream/master || exit 4

cecho --info '$ git push'
git push || exit 5

cecho --info '$ git push --tags'
git push --tags || exit 6

exit 0

# vim: set noet sts=0 ts=4 sw=4 sr tw=72:
