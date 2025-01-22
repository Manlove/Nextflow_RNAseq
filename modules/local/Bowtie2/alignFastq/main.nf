#!/usr/bin/env nextflow

/*
 * Align fastq files with bowtie2
*/

process ALIGNFASTQ {

    container "community.wave.seqera.io/library/bowtie2:2.5.4--d51920539234bea7"
    
    input:
	tuple (val(fastq_name), path(input_fastq))
	path(refFile)
    output:
	path "${fastq_name}.sam", emit: samFile

    script:
    """
    bowtie2 -x ${refFile}/refFile -1 ${input_fastq[0]} -2 ${input_fastq[1]} > ${fastq_name}.sam 
    """
}
