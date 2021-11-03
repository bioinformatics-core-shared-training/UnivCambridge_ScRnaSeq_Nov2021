# Introduction to single-cell RNA-seq data analysis 
### 4th, 11th and 18th Nov 2021
#### Taught remotely
#### Bioinformatics Training, Craik-Marshall Building, Downing Site, University of Cambridge

![](Images/CRUK_CC_whiteBgd.jpg)

## Instructors

* Abigail Edwards - Bioinformatics Core, Cancer Research UK Cambridge Institute
* Ashley Sawle - Bioinformatics Core, Cancer Research UK Cambridge Institute
* Hugo Tavares - Bioinformatics Training Facility, University of Cambridge
* Katarzyna Kania - Genomics Core, Cancer Research UK Cambridge Institute
* Stephane Ballereau - Bioinformatics Core, Cancer Research UK Cambridge Institute

## Outline

This workshop is aimed at biologists interested in learning how to perform
standard single-cell RNA-seq analyses. 

This will focus on the droplet-based assay by 10X genomics and include running
the accompanying `cellranger` pipeline to align reads to a genome reference and
count the number of read per gene, reading the count data into R, quality control,
normalisation, data set integration, clustering and identification of cluster
marker genes, as well as differential expression and abundance analyses.
You will also learn how to generate common plots for analysis and visualisation
of gene expression data, such as TSNE, UMAP and violin plots.

We have run this course twice and are still learning how to teach it remotely.
Please bear with us if there are any technical hitches, and be aware that timings
for different sections laid out in the schedule below may not be adhered to.
There may be some necessity to make adjusments to the course as we go.

> ## Prerequisites
>
> __**Some basic experience of using a UNIX/LINUX command line is assumed**__
> 
> __**Some R knowledge is assumed and essential. Without it, you
> will struggle on this course.**__ 
> If you are not familiar with the R statistical programming language we
> strongly encourage you to work through an introductory R course before
> attempting these materials.
> We recommend our [Introduction to R course](https://bioinformatics-core-shared-training.github.io/r-intro/)

## Data sets

Two data sets:

* '[CaronBourque2020](https://www.nature.com/articles/s41598-020-64929-x)': pediatric leukemia, with four sample types, including:
  * pediatric Bone Marrow Mononuclear Cells (PBMMCs)
  * three tumour types: ETV6-RUNX1, HHD, PRE-T  
* ['HCA': adult BMMCs](https://data.humancellatlas.org/explore/projects/cc95ff89-2e68-4a08-a234-480eca21ce79) (ABMMCs) obtained from the Human Cell Atlas (HCA)
  * (here downsampled from 25000 to 5000 cells per sample)

## Tentative schedule

**Tentative schedule** for a 3-day course.

### Day 1: Thursday 4th Nov

* 09:30 - 09:40 Welcome <!-- Paul -->
* 09:40 - 10:25 Introduction - Katarzyna Kania
    + [Slides](Slides/Introduction_to_Single_Cell_RNAseq_CRUK_Kania_23rd_July_2021.pdf)
* 10:25 - 10:30 5 min break 
* 10:30 - 10:40 Preamble: data set and workflow - Stephane Ballereau
    + [Slides](Slides/dataSetSlides.html)
* 10:40 - 12:30 Library structure, cellranger for alignment and cell calling, preprocessing - Stephane Ballereau
    + [Slides](Slides/CellRangerSlides.html) <!-- \([pdf](scRNAseq/Slides/CellRangerSlides.pdf)\) -->
    + [Alignment with Cell Ranger](Markdowns/cellRanger.html)

* 12:30 - 13:30 lunch break

* 13:30 - 17:30 QC and exploratory analysis - Ashley Sawle
    + [Slides](Slides/QualityControlSlides.html) \([pdf](Slides/QualityControlSlides.pdf)\)
    + [QC and preprocessing](Markdowns/04_Preprocessing_And_QC.html)     
    <!-- + [Exercise](Markdowns/04_Preprocessing_And_QC.Exercise.html) -->

### Day 2: Thursday 11th Nov

* 09:30 - 09:40 Recap <!-- Stephane -->
* 09:40 - 12:30 Normalisation - Stephane Ballereau
    + [Slides](Slides/normalisationSlides.html) <!-- \([pdf](scRNAseq/Slides/normalisationSlides.pdf)\) -->
    + [Practical](Markdowns/normalisation_5hCellPerSpl_caron.html)     
    <!-- + [Exercise Solutions](Markdowns/normalisation_exercise_solutions.html) -->

* 12:30 - 13:30 lunch break

* 13:30 - 15:25 Feature selection and dimensionality reduction - Hugo Tavares
    + [Slides](Slides/FeatureSelectionAndDimensionalityReductionSlides.html)
    + [Dimensionality reduction, feature selection](Markdowns/dimRedFeatSel_2021.html)
    <!-- + [Exercise Solutions](CourseMaterials/Challenges/DimRedChallengeSolutions.html) -->
* 15:25 - 15:35 10 min break 
* 15:35 - 17:30 Batch correction and data set integration - Abigail Edwards
    + [Slides](Slides/DataIntegrationAndBatchCorrectionSlides.html)  
    + [Data set integration](Markdowns/dataSetIntegration_PBMMC_ETV6-RUNX1.html)
    <!-- extended ? -->

### Day 3: Thursday 18th Nov

* 09:30 - 09:40 Recap <!-- Stephane -->
* 09:40 - 11:05 Clustering - Stephane Ballereau
    + [Slides](Slides/clusteringSlides.html)
    + [Practical](Markdowns/clusteringPostDsi.html)     
    <!-- + [Exercise Solutions](scRNAseq/Markdowns/clusteringPostDsi_exercise_solution.html) -->
* 11:05 - 11:15 10 min break 
* 11:15 - 12:30 Identification of cluster marker genes - Hugo Tavares
    + [Slides](Slides/MarkerIdentificationSlides.html)
    + [Cluster marker genes](Markdowns/ClusterMarkerGenes2021.html)
    <!-- + [Exercise Solutions](scRNAseq/CourseMaterials/Challenges/ClusterMarkerGenes2021.Exercise.Solutions.html) -->

* 12:30 - 13:30 lunch break

* 13:30 - 15:25 Differential expression between conditions <!-- Stephane -->
    + [Slides](scRNAseq/Slides/multiSplCompSlides.html)
    + [Practical](scRNAseq/Markdowns/multiSplComp.html)     
    <!-- + [Exercise1 Solutions](scRNAseq/Markdowns/multiSplComp_exercise1_solutions.html) -->
    <!-- + [Exercise2 Solutions](scRNAseq/Markdowns/multiSplComp_exercise2_solutions.html) -->
* 15:25 - 15:35 10 min break 
* 15:35 - 17:30 Differential abundance between conditions <!-- Stephane -->
    + [Slides](scRNAseq/Slides/multiSplCompSlides.html)
    + [Practical](scRNAseq/Markdowns/multiSplComp.html)     
    <!-- + [Exercise1 Solutions](scRNAseq/Markdowns/multiSplComp_exercise1_solutions.html) -->
    <!-- + [Exercise2 Solutions](scRNAseq/Markdowns/multiSplComp_exercise2_solutions.html) -->
