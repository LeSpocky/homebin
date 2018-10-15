#!/bin/sh
# taken and modified from https://stackoverflow.com/a/48974449/462636
t="$(ntptime | grep "time " | head -n1 | awk '{print $2}')"
if [ -z "$1" ]
then
    if=eth0
    EUI_48="$(ip a s dev $if | grep "link/ether" | awk '{print $2}')"
else
    EUI_48="$1"
fi
EUI_64="$(ipv6calc --action prefixmac2ipv6 --in prefix+mac --out ipv6addr :: $EUI_48 | sed 's/^:://')"
conq="$(echo "$t $EUI_64" | tr -d ".: ")"
sha1="$(for x in $(echo "$conq" | sed 's/\(..\)/\1 /g') ; do printf "\x${x}" ; done | sha1sum | awk '{print $1}' | tail -c 11 | sed 's/\(..\)/\1 /g')"
ULA="$(echo $sha1 | awk '{print "fd" $1 ":" $2 $3 ":" $4 $5 "::/48"}')"
echo "$t $EUI_48 $EUI_64 $conq=> $ULA"
