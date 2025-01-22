#!/usr/bin/env nextflow

/*
* Indexes a reference file using bowtie2 
*/

process INDEXREFERENCE {

    container "community.wave.seqera.io/library/bowtie2:2.5.4--d51920539234bea7"
    
    input:
	path referenceFile

    output:
	path "refFile"

    script:
    """
    mkdir refFile
    bowtie2-build $referenceFile refFile/refFile
    """
}
