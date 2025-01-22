#!/usr/bin/env nextflow

/*
*  Quantify read alignments with featureCounts
*/

process featureCounts {

    container "community.wave.seqera.io/library/subread:2.0.8--2d7f922ff219454e"

    publishDir "$params.outdir/counts", mode: 'copy'

    input:
	path annotationFile
	path bamFiles

    output:
	path "feature_counts.txt"

    script:
    """
    featureCounts -p --countReadPairs -T 4 -t exon -g gene_id -a ${annotationFile} -o feature_counts.txt ${bamFiles}
    """
}
