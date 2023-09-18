#!/bin/sh

command="porte-cles"
args=""
topic="PORTE-CLES"
server="ntfy.sh"
tmpFile="time.log"

while getopts ":c:a:t:s:f:" opt; do
  case $opt in
    c) command="$OPTARG"
    ;;
    a) args="$OPTARG"
    ;;
    t) topic="$OPTARG"
    ;;
    s) server="$OPTARG"
    ;;
    f) tmpFile="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    exit 1
    ;;
  esac
done

/usr/bin/time -f 'real %e' -o ${tmpFile} ${command} ${args}
eTime=$( awk -F 'real' '{  {print $2} }' ${tmpFile} )
text=${command}" done in "${eTime}"s"
curl -d "${text}" ${server}/${topic} > /dev/null 2>&1
rm ${tmpFile}
