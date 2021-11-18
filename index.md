# Introduction to single-cell RNA-seq data analysis 
### 4th, 11th and 18th Nov 2021
#### Taught remotely
#### Bioinformatics Training, Craik-Marshall Building, Downing Site, University of Cambridge

![](Images/uniOfCamCrukLogos.png)

## Instructors

* Abigail Edwards - Bioinformatics Core, Cancer Research UK Cambridge Institute
* Ashley Sawle - Bioinformatics Core, Cancer Research UK Cambridge Institute
* Hugo Tavares - Bioinformatics Training Facility, University of Cambridge
* Katarzyna Kania - Genomics Core, Cancer Research UK Cambridge Institute
* Stephane Ballereau - Bioinformatics Core, Cancer Research UK Cambridge Institute

**Helpers:**

* Chandra Chilamakuri - Bioinformatics Core, Cancer Research UK Cambridge Institute
* Chloe Pacyna - Wellcome Sanger Institute
* Jon Price - The Gurdon Institute, University of Cambridge
* Karsten Bach - Department of Pharmacology, University of Cambridge

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

(Materials linked to below will be updated closer to the time of delivery)

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

(long sessions include breaks)

### Day 1: Thursday 4th Nov

* 09:30 - 09:40 **Welcome** <!-- Paul -->
* 09:40 - 10:25 **Introduction** - Katarzyna Kania
    + [Slides](Slides/01_Introduction.pdf)
* 10:25 - 10:30 5 min **break** 
* 10:30 - 10:40 **Preamble**: data set and workflow - Stephane Ballereau
    + [Slides](Slides/02_PreambleSlides.html)
* 10:40 - 12:30 Library structure, **cellranger** for alignment and cell calling - Stephane Ballereau
    + [Slides](Slides/03_CellRangerSlides.html) <!-- \([pdf](scRNAseq/Slides/CellRangerSlides.pdf)\) -->
    + [Alignment with Cell Ranger](Markdowns/03_CellRanger.html)
* 12:30 - 13:30 **lunch break**
* 13:30 - 17:30 **QC and exploratory analysis** - Ashley Sawle
    + [Slides](Slides/04_QualityControlSlides.html) \([pdf](Slides/04_QualityControlSlides.pdf)\)
    + [QC and preprocessing](Markdowns/04_Preprocessing_And_QC.html)     
    + [Exercise](Markdowns/04_Preprocessing_And_QC.Exercise.html)  

### Day 2: Thursday 11th Nov

* 09:30 - 09:40 Recap <!-- Stephane -->
* 09:40 - 12:30 **Normalisation** - Stephane Ballereau
    + [Slides](Slides/05_NormalisationSlides.html) <!-- \([pdf](scRNAseq/Slides/05_normalisationSlides.pdf)\) -->
    + [Practical](Markdowns/05_Normalisation.html)     
    + [Exercises](Markdowns/05_Normalisation_exercises.html)
    + [Exercise Solutions](Markdowns/05_Normalisation_exercises_solutions.html)
* 12:30 - 13:30 **lunch break**
* 13:30 - 15:25 **Feature selection and dimensionality reduction** - Hugo Tavares
    + [Slides](Slides/06_FeatureSelectionAndDimensionalityReduction_slides.html)
    + [Materials](Markdowns/06_FeatureSelectionAndDimensionalityReduction.html)
* 15:25 - 15:35 10 min **break**
* 15:35 - 17:30 **Batch correction and data set integration** - Abigail Edwards
    + [Slides](Slides/07_DataIntegrationAndBatchCorrectionSlides.html)  
    + [Data set integration](Markdowns/07_DataSetIntegration_PBMMC_ETV6-RUNX1.html)
    <!-- extended ? -->

### Day 3: Thursday 18th Nov

* 09:30 - 09:40 Recap <!-- Stephane -->
* 09:40 - 11:05 **Clustering** - Stephane Ballereau
    + [Slides](Slides/08_ClusteringSlides.html)
    + [Practical](Markdowns/08_ClusteringPostDsi.html)     
    + [Exercise1](scRNAseq/Markdowns/08_ClusteringPostDsi_exercise.Rmd) -->
    <!-- + [Exercise Solutions](scRNAseq/Markdowns/08_ClusteringPostDsi_exercise_solutions.html) -->
* 11:05 - 11:15 10 min **break** 
* 11:15 - 12:30 **Identification of cluster marker genes** - Hugo Tavares
    + [Slides](Slides/09_ClusterMarkerGenes.html)
    + [Cluster marker genes](Markdowns/09_ClusterMarkerGenes.html)
    + Worksheet in `Exercises/09_ClusterMarkerGenes.R`
* 12:30 - 13:30 **lunch break**
* 13:30 - 15:25 **Differential expression between conditions** - Stephane Ballereau
    + [Slides](Slides/10_MultiSplCompSlides.html)
    + [Practical](Markdowns/10_MultiSplComp.html)     
    <!-- + [Exercise1 Solutions](scRNAseq/Markdowns/10_MultiSplComp_exercise1_solutions.html) -->
    <!-- + [Exercise2 Solutions](scRNAseq/Markdowns/10_MultiSplComp_exercise2_solutions.html) -->
* 15:25 - 15:35 10 min **break** 
* 15:35 - 17:30 **Differential abundance between conditions** - Stephane Ballereau
    + [Slides](Slides/10_MultiSplCompSlides.html)
    + [Practical](Markdowns/10_MultiSplComp.html)     
    <!-- + [Exercise1 Solutions](scRNAseq/Markdowns/10_MultiSplComp_exercise1_solutions.html) -->
    <!-- + [Exercise2 Solutions](scRNAseq/Markdowns/10_MultiSplComp_exercise2_solutions.html) -->
