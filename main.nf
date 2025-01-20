include { runFastQC } from './modules/local/FastQC/main.nf'
include { indexReference } from './modules/local/Bowtie2/indexReference/main.nf'
include { alignFile } from './modules/local/Bowtie2/alignFile/main.nf'

params.fastq_path = "/Users/logan/Documents/Nextflow_RNAseq/data/*{1,2}.fq"

workflow {
	fastq_files = Channel.fromFilePairs(params.fastq_path)
	refFile = Channel.fromPath(params.reference)

	runFastQC(fastq_files)
	indexRef = indexReference(refFile)	
	alignFile(fastq_files, indexRef)
}
