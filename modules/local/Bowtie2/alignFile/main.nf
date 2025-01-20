#!/usr/bin/env nextflow

/*
 * Align fastq files with bowtie2
*/

process alignFile {

    container "community.wave.seqera.io/library/bowtie2:2.5.4--d51920539234bea7"
    
    publishDir "$params.outdir/BAM", mode: 'copy'

    input:
	tuple (val(fastq_name), path(input_fastq))
	path refFile
	tuple (path(b1), path(b2), path(b3), path(b4))
	tuple (path(brev1), path(brev2)
)
    output:
	path "*.sam"

    script:
    """
    bowtie2 -x ${projectDir}/results/ref/refFile -1 ${input_fastq[0]} -2 ${input_fastq[1]} > ${fastq_name}.sam 
    """
}
