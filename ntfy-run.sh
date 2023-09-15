#!/bin/sh

command="${1:-porte-cles}"
args="${2:-}"
topic="${3:-PORTE-CLES}"
tmpFile="${4:-time.log}"
server="${5:-ntfy.sh}"

/usr/bin/time -f 'real %e' -o ${tmpFile} ${command} ${args} > /dev/null 2>&1
eTime=$( awk -F 'real' '{  {print $2} }' ${tmpFile} )
text=${command}" done in "${eTime}"s"
curl -d "${text}" ${server}/${topic} > /dev/null 2>&1
rm ${tmpFile}
