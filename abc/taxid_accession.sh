#! /usr/bin/env bash

set -u
set -f
set -e
set -o pipefail

PROGDIR=$(dirname $0)
FILE=$PROGDIR/table_sd2.tsv
THREADS=1

function accession ()
{
	local taxid=$1
	local ers=${26}
	local err=$(curl -s "http://www.ebi.ac.uk/ena/data/view/${ers}&display=xml" | perl -pe 's/\n//g' | perl -pe 's/.*(ERR[0-9]+).*/\1/g')
	printf "%s\t%s\t%s\n" $taxid $ers $err
}

export -f accession

parallel -j $THREADS --colsep '\t' --skip-first-line --halt now,fail=1 --no-notice accession :::: ${FILE}

