# Load packages ----
library(scater)
library(scran)
library(pheatmap)
library(tidyverse) # always load tidyverse after other packages


# Read data ----

# normalised within batches without batch-integration correction
uncorrected <- readRDS("Robjects/DataIntegration_uncorrected.Rds")
rownames(uncorrected) <- uniquifyFeatureNames(rownames(uncorrected), rowData(uncorrected)$Symbol)

# data corrected using batch integration with mutual nearest neighbours
corrected <- readRDS("Robjects/caron_postDeconv_5hCellPerSpl_dsi_PBMMC_ETV6-RUNX1_clust.Rds")
rownames(corrected) <- uniquifyFeatureNames(rownames(corrected), rowData(corrected)$Symbol)

# visualise cluster assignments on the corrected data
plotUMAP(corrected, 
         colour_by = "louvain", 
         text_by = "louvain")

# copy cluster assignments to the uncorrected object
# first make sure that the cell names are in the same order
all(colnames(uncorrected) == colnames(corrected))
colData(uncorrected)$louvain <- factor(colData(corrected)$louvain)

# visualise a previously known marker gene (for monocytes)
plotTSNE(corrected, 
         colour_by = "CST3", 
         text_by = "louvain", 
         by_exprs_values = "reconstructed")


# Marker gene identification ----

# identify marker genes based on mean expression differences
# default options do not need to be specified, but shown here for illustration
markers_default <- findMarkers(
  uncorrected, 
  groups = factor(corrected$louvain), # clusters to compare
  block = uncorrected$SampleGroup,    # covariates in statistical model
  test.type = "t",   # t-test (default)
  direction = "any", # test for either higher or lower expression (default)
  lfc = 0, # null hypothesis log-fold-change = 0 (default)
  pval.type = "any" # ranking of p-values based on any comparison (default)
)

# returns a list of length equal to the number of clusters
markers_default

# check the result of a particular cluster
markers_default[[8]]

# extract results for one of the clusters
c8_markers_default <- markers_default[[8]]
c8_markers_default[1:10, c(1, 5:14)]

# identify set of genes in the top 3 p-value ranking
c8_markers_default[c8_markers_default$Top <= 3, ]

# visualise one of the top genes using MNN-corrected values
plotTSNE(corrected, 
         colour_by = "LYZ", 
         text_by = "louvain", 
         by_exprs_values = "reconstructed")

# visualise the expression of the gene on the uncorrected values
plotExpression(uncorrected, 
               features = "LYZ", 
               x = "louvain")


# Exercise: Test for up-regulated genes ----

# HBA1 gene was one of the top genes in previous analysis
# but it is NOT expressed in cluster 8
plotExpression(uncorrected,
               features = "HBA1",
               x = "louvain")

# modify the previous call to findMarkers to focus on genes that are up-regulated
markers_up <- findMarkers(FIXME)

# extract the results for cluster 8 and check that this gene is no longer on top
c8_markers_up <- FIXME

# can you find out what the rank of HBA1 is now?



# Considering log-fold change threshold ----

# These two genes were significant in previous analysis
# but TSPO has less impressive difference compared to LYZ
plotExpression(uncorrected, 
               features = c("TSPO", "LYZ"), 
               x = "louvain")

# testing for the alternative hypothesis that LFC > 1
markers_up_lfc1 <- findMarkers(
  uncorrected, 
  groups = factor(corrected$louvain), # clusters to compare
  block = uncorrected$SampleGroup,    # covariates in statistical model
  test.type = "t",   # t-test (default)
  direction = "up", # test for up-regulated genes only
  lfc = 1, # null hypothesis log-fold-change = 1
  pval.type = "any" # ranking of p-values based on any comparison (default)
)

# fetching top markers for cluster 8
c8_markers_up_lfc1 <- markers_up_lfc1[[8]]
c8_markers_up_lfc1[c8_markers_up_lfc1$Top <= 3, ]


# Considering p-value summary ----

# This gene is more highly expressed in cluster 8 but only compared to some clusters
plotExpression(uncorrected, 
               features = c("TMSB10"), 
               x = "louvain")

# ranking based on the maximum p-value across all pairwise comparisons
markers_up_all <- findMarkers(
  uncorrected, 
  groups = factor(corrected$louvain), # clusters to compare
  block = uncorrected$SampleGroup,    # covariates in statistical model
  test.type = "t",   # t-test (default)
  direction = "up", # test for up-regulated genes only
  lfc = 0, # null hypothesis log-fold-change = 1
  pval.type = "all" # ranking of p-values based on all comparisons
)

# fetching top markers for cluster 8
c8_markers_up_all <- markers_up_all[[8]]
c8_markers_up_all[1:10, ]


# Heatmaps ----

# select some top genes for cluster 8
c8_top10 <- c8_markers_up_lfc1[c8_markers_up_lfc1$Top <= 10, ]

# heatmap of expression values
plotHeatmap(uncorrected, 
            features = rownames(c8_top10),
            order_columns_by = c("louvain", "SampleGroup"))

# heatmap of log-fold-changes
pheatmap(c8_top10[, 5:14], 
         breaks=seq(-5, 5, length.out=101))


# Alternative testing strategies ----

# Wilcoxon rank-sum test
markers_wilcox_up <- findMarkers(
  uncorrected, 
  groups = uncorrected$louvain, # clusters to compare
  block = uncorrected$SampleGroup,    # covariates in statistical model
  test.type = "wilcox",   # t-test (default)
  direction = "up"
)

c8_markers_wilcox_up <- markers_wilcox_up[[8]]
head(c8_markers_wilcox_up)

# make a heatmap of AUC values
# we use a custom colour palette that diverges around 0.5
# we optionally do not cluster rows to keep genes in their ranking order
pheatmap(c8_markers_wilcox_up[c8_markers_wilcox_up$Top <= 6, 5:14],
         breaks = seq(0, 1, length.out = 21),
         color = viridis::cividis(21), 
         cluster_rows = FALSE)

# Binomial test of proportions
markers_binom_up <- findMarkers(
  uncorrected, 
  groups = uncorrected$louvain, # clusters to compare
  block = uncorrected$SampleGroup,    # covariates in statistical model
  test.type = "binom",   # t-test (default)
  direction = "up"
)

# make a heatmap of expression values for top genes in cluster 8
c8_markers_binom_up <- markers_binom_up[[8]]
plotExpression(uncorrected, 
               x = "louvain",
               features = rownames(c8_markers_binom_up)[1:4])


# Combining multiple tests ----

markers_combined <- multiMarkerStats(
  t = findMarkers(
    uncorrected,
    groups = uncorrected$louvain,
    direction = "up",
    block = uncorrected$SampleGroup
  ),
  wilcox = findMarkers(
    uncorrected,
    groups = uncorrected$louvain,
    test = "wilcox",
    direction = "up",
    block = uncorrected$SampleGroup
  ),
  binom = findMarkers(
    uncorrected,
    groups = uncorrected$louvain,
    test = "binom",
    direction = "up",
    block = uncorrected$SampleGroup
  )
)

# the first few rows and columns of the combined results table
markers_combined[[8]][1:10 , 1:9]
