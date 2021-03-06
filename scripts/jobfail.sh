#!/usr/bin/env bash

set -e

echo "Update Rally"
echo "- set variables"
CURDIR=`pwd`
US=`git log -1 | grep US`
echo ${US}
export TZ="Asia/Tokyo"
DTSTR=`date "+%Y/%m/%d-%H:%M"`
echo ${DTSTR}
TXT="componentSampleJobFAILURE!!!(${DTSTR})"
echo ${TXT}
ACT=2
echo ${ACT}

cd scripts/AgileAPIScript_Run
chmod 555 ./agileApiObjectHandleBash.sh 
./agileApiObjectHandleBash.sh ${ACT} ${US} ${TXT}

ACT=4
echo ${ACT}
./agileApiObjectHandleBash.sh ${ACT} ${US} ${TXT}

cd ${CURDIR}
pwd