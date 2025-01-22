#!/usr/bin/env nextflow

/*
 * Call variants with GATK HaplotypeCaller
 */

process indexReference {

    container "community.wave.seqera.io/library/bowtie2:2.5.4--d51920539234bea7"
    
//    publishDir "ref", mode: 'link'

    input:
	path referenceFile

    output:
	path "refFile"

//	path referenceFile
//	path "refFile.{1,2,3,4}.bt2"
//	path "refFile.rev.{1,2}.bt2" 
	

    script:
    """
    mkdir refFile
    bowtie2-build $referenceFile refFile/refFile
    """
}
