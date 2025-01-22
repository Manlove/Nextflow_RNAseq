#!/usr/bin/env nextflow

/*
* Convert a samfile to a bam file
*/

process SAM2BAM {

    container "community.wave.seqera.io/library/samtools:1.21--0d76da7c3cf7751c"
    
    input:
	path samFile

    output:
	path "*.bam"

    script:
    """
    samtools view -bS ${samFile} > ${samFile.baseName}.bam
    """
}
