#! /usr/bin/env bash
set -f -o pipefail

THREADS=10
FILE=../isolates.2015.tsv

function download_isolate ()
{
	taxid=$2
	accession=$4
    a=`echo ${accession:0:6}`
    b="$accession"
    c="$accession"
	fq1=${taxid}_1.fastq
	fq2=${taxid}_2.fastq
	echo "Downloading isolate $taxid (accession $3)"
    url1="ftp://ftp.sra.ebi.ac.uk/vol1/fastq/$a/$b/${c}_1.fastq.gz"
    url2="ftp://ftp.sra.ebi.ac.uk/vol1/fastq/$a/$b/${c}_2.fastq.gz"
    echo $url1
	set -x
	curl -s $url1 | gzip -d > $fq1
	test -s $fq1
	curl -s $url2 | gzip -d > $fq2
	test -s $fq2
}

export -f download_isolate

parallel -j $THREADS --colsep '\t' --skip-first-line --halt now,fail=1 --no-notice download_isolate :::: ${FILE}

