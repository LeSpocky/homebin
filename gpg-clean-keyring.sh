#!/bin/bash

SCRIPTDIR="$(dirname ${0})"

# do color output if COLORTERM is set, if colsh_definitions.inc is not
# included, cecho just outputs without color
if [ "${COLORTERM}" = 'yes' ]
then
    . "${SCRIPTDIR}/colsh/colsh_definitions.inc"
fi
. "${SCRIPTDIR}/colsh/colsh_cecho.inc"

### main
for KEYID in `gpg --list-keys --fixed-list-mode --with-colons | grep '^pub' | cut -f5 -d':'` 
do
    cecho --info "gpg --refresh-keys ${KEYID}"
    gpg --batch --refresh-keys $KEYID
    sleep 3
    gpg --batch --edit-key $KEYID clean save
    cecho --msg '----------- ----------- -----------'
    sleep 3
done
