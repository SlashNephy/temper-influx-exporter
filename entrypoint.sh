#!/bin/ash

set -eu

while true
do
    sleep ${INTERVAL}

    temp=`timeout 10 temper_json | jq ".temperature"`
    status=`curl --write-out '%{http_code}' -s --output /dev/null -X POST "${INFLUX_ADDR}/write?db=${INFLUX_DB}&precision=s" --data-binary "temp value=${temp}"`

    if [ $status -ge 400 ] ; then
        exit
    fi
done
