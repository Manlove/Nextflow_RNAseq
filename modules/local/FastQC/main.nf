#!/usr/bin/env nextflow

/*
 * Call variants with GATK HaplotypeCaller
 */

params.outdir = "results"

process runFastQC {

    container "community.wave.seqera.io/library/fastqc:0.12.1--af7a5314d5015c29"
    publishDir "$params.outdir/QC", mode: 'copy'
    input:
	tuple (val(input_name),path(input_fastq))

    output:
	path "*.zip"
	path "*.html"

    script:
    """
    echo $input_fastq
    fastqc $input_fastq
    """
}
