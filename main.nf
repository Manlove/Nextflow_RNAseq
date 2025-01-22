include { RUNFASTQC } from './modules/local/FastQC/main.nf'
include { INDEXREFERENCE } from './modules/local/Bowtie2/indexReference/main.nf'
include { ALIGNFASTQ } from './modules/local/Bowtie2/alignFastq/main.nf'
include { SAM2BAM } from './modules/local/samtools/sam2bam/main.nf'
include { INDEXBAM } from './modules/local/samtools/indexBam/main.nf'
include { FEATURECOUNTS } from './modules/local/subread/featureCounts/main.nf'
include { CLEANCOUNTS } from './modules/local/custom/cleanCounts/main.nf'

params.fastq_path = "/Users/logan/Documents/Nextflow_RNAseq/data/*{1,2}.fq"

workflow {
	fastq_files = Channel.fromFilePairs(params.fastq_path, checkIfExists: true)
	RUNFASTQC(fastq_files)
	INDEXREFERENCE(params.reference)	
	
	ALIGNFASTQ(fastq_files, INDEXREFERENCE.out)
	SAM2BAM(ALIGNFASTQ.out)
	INDEXBAM(SAM2BAM.out)
	
	bamFiles = INDEXBAM.out.map{_,bam -> bam }.collect() 
	FEATURECOUNTS(params.gtfFile, bamFiles)
	CLEANCOUNTS(FEATURECOUNTS.out)
}
