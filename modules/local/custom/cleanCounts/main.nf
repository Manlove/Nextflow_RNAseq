#!/usr/bin/env nextflow

/*
*  Create counts file from feature counts output to read into DESeq2
*/

process CLEANCOUNTS {

    publishDir "$params.outdir/counts", mode: 'copy'

    input:
	path featureFile

    output:
	path "counts.txt"

    script:
    """
    tail +2 ${featureFile} | cut -f1,7- > counts.txt
    """
}
