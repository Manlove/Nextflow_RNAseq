#!/usr/bin/env nextflow

/*
 * Align fastq files with bowtie2
*/

process alignFile {

    container "community.wave.seqera.io/library/bowtie2:2.5.4--d51920539234bea7"
    
    publishDir "$params.outdir/BAM", mode: 'copy'

    input:
	tuple (val(fastq_name), path(input_fastq))
	path(refFile)
    output:
	path "*.sam"

    script:
    """
    bowtie2 -x ${refFile}/refFile -1 ${input_fastq[0]} -2 ${input_fastq[1]} > ${fastq_name}.sam 
    """
}
