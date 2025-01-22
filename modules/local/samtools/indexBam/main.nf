#!/usr/bin/env nextflow

/*
* Convert a samfile to a bam file
*/

process indexBam {

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
