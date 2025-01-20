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
	tuple  (path("*.bam.bai"), path(bamFile))

    script:
    """
    samtools index ${bamFile}
    """
}
