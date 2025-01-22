if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("DESeq2")

library( "DESeq2" )
library(ggplot2)

metadata <- read.csv("/Users/logan/Documents/Nextflow_RNASeq/data/metadata.csv",header=TRUE)
countData <- read.table("/Users/logan/Documents/Nextflow_RNASeq/results/counts/counts.txt",header=TRUE)

rownames(countData) <- countData$Geneid
countData <- countData[, -which(names(countData) == "Geneid")]
head(countData)

dds <- DESeqDataSetFromMatrix(countData=countData, colData=metadata, design=~tissue)
