include { runFastQC } from './modules/local/FastQC/main.nf'
include { indexReference } from './modules/local/Bowtie2/indexReference/main.nf'
include { alignFile } from './modules/local/Bowtie2/alignFile/main.nf'
include { sam2bam } from './modules/local/samtools/sam2bam/main.nf'
include { sortBam } from './modules/local/samtools/sortBam/main.nf'
include { indexBam } from './modules/local/samtools/indexBam/main.nf'
include { featureCounts } from './modules/local/subread/featureCounts/main.nf'

params.fastq_path = "/Users/logan/Documents/Nextflow_RNAseq/data/*{1,2}.fq"

workflow {
	fastq_files = Channel.fromFilePairs(params.fastq_path)
	runFastQC(fastq_files)
	indexRef = indexReference(params.reference)	
	alignFile(fastq_files, indexRef[0])
	sam2bam(alignFile.out)
	indexBam(sam2bam.out)
	
	bamFiles = indexBam.out.map{_,bam -> bam }.collect() 
	featureCounts(params.gtfFile, bamFiles)
}
