#!/usr/bin/env nextflow

/*
* Sort and index an input bam file using samtools
*/

process INDEXBAM {

    container "community.wave.seqera.io/library/samtools:1.21--0d76da7c3cf7751c"
    
    publishDir "$params.outdir/BAM", mode: 'copy'

    input:
	path bamFile

    output:
	tuple (path("${bamFile.baseName}_sorted.bam.bai"), path("${bamFile.baseName}_sorted.bam"))

    script:
    """
    samtools sort ${bamFile} >  ${bamFile.baseName}_sorted.bam
    samtools index ${bamFile.baseName}_sorted.bam
    """
}
