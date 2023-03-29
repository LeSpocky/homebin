#!/bin/bash
# This generates lore-friendly message-id headers that are safe, unique, and
# provide better UX for someone using lore to retrieve messages.
#
# Instructions for using with mutt/neomutt:
#
# Save this as ~/bin/my-gen-msgid, then add ~/.mutt-fix-msgid with the following,
# fixing your path to the file:
#
# my_hdr Message-ID: <`/home/user/bin/my-gen-msgid`>
#
# then edit ~/.muttrc to add:
#
# send-hook . "source ~/.mutt-fix-msgid"
#
# I like my msgid to start with the date
msgid="$(date +%Y%m%d)"
if [ -x /usr/bin/diceware ]
then
    # I like memorable nonsense, so I can visually tell one message from another,
    # by looking at the lore URL, so use diceware for that
    msgid="${msgid}-$(diceware --no-caps -d- -n2)-$(openssl rand -hex 6)"
else
    # Just use openssl with some extra randomness
    msgid="${msgid}-$(openssl rand -hex 12)"
fi
echo -n "${msgid}@$(hostname -d)"
