# load packages ----

library(scater) 
library(scran)
library(PCAtools)
library(tidyverse) # always load tidyverse after other packages


# read data ----

sce <- readRDS("Robjects/caron_postDeconv_5hCellPerSpl.Rds")
sce

# use common gene names instead of Ensembl gene IDs
rownames(sce) <- uniquifyFeatureNames(rownames(sce), rowData(sce)$Symbol)



# Mean-variance model ----

# fit the model; the output is a DataFrame object
gene_var <- modelGeneVar(sce)

# plot the variance against mean of expression with fitted trend line
gene_var %>% 
  # convert to tibble for ggplot
  as_tibble() %>% 
  # make the plot
  ggplot(aes(mean, total)) +
  geom_point() +
  geom_line(aes(y = tech), colour = "dodgerblue", size = 1) +
  labs(x = "Mean of log-expression", y = "Variance of log-expression")

# identify the top 10% most variable genes
hvgs <- getTopHVGs(gene_var, prop=0.1)
length(hvgs) # check how many genes we have
hvgs[1:10] # check the first 10 of those genes

# visualise expression of top HGVs
# point_alpha adds transparency to the points
# jitter option determines the way in which the points are "jittered"
# try running this with and without those options to see the difference
plotExpression(sce, features = hvgs[1:20], point_alpha = 0.05, jitter = "jitter")



# PCA ----

sce <- runPCA(sce, subset_row = hvgs)
sce

# the result is stored as a matrix 
# we print only the first few rows and columns for convenience
reducedDim(sce, "PCA")[1:10, 1:5]

# extract variance explained
pca_pct_variance <- data.frame(variance = attr(reducedDim(sce, "PCA"), "percentVar"))
pca_pct_variance$PC <- 1:nrow(pca_pct_variance)

# visualise percentage variance explained by PCs (scree plot)
pca_pct_variance %>% 
  ggplot(aes(PC, variance)) +
  geom_col() +
  labs(y = "Variance explained (%)")

# visualise PC plot
plotReducedDim(sce, dimred = "PCA", colour_by = "SampleName")

# visualise multiple PCs
plotReducedDim(sce, dimred = "PCA", ncomponents = 3, colour_by = "SampleName")

# more custom visualisations with ggcells (e.g. add facets)
ggcells(sce, aes(x = PCA.1, y = PCA.2, colour = SampleName)) +
  geom_point(size = 0.5) +
  facet_wrap(~ SampleName) +
  labs(x = "PC1", y = "PC2", colour = "Sample")

# extract correlations between different variables and our PC scores
explan_pcs <- getExplanatoryPCs(sce,
    variables = c(
        "sum",
        "detected",
        "SampleGroup",
        "SampleName",
        "subsets_Mito_percent"
    )
)

plotExplanatoryPCs(explan_pcs/100)

# distribution of correlations between each gene's expression and our variables of interest
plotExplanatoryVariables(sce,
                         variables = c(
                           "sum",
                           "detected",
                           "SampleGroup",
                           "SampleName",
                           "subsets_Mito_percent"
                         ))



# identify elbow point from explained variances
chosen_elbow <- findElbowPoint(pca_pct_variance$variance)
chosen_elbow

# scree plot (PC vs variance) with elbow highlighted
pca_pct_variance %>% 
  ggplot(aes(PC, variance)) +
  geom_point() +
  geom_vline(xintercept = chosen_elbow)

# run denoise PCA step
sce <- denoisePCA(sce, technical = gene_var)

# check dimensions of the "denoised" PCA
ncol(reducedDim(sce, "PCA"))



# Run t-SNE ----

# add the t-SNE result to the reducedDim slot of the SCE object
# we name this reducedDim "TSNE_perplex50"
# we set perplexity = 50 (which is the default if we don't specify it)
# we run t-SNE based on the PCA we ran previously
set.seed(123) # set a random seed to ensure reproducibility
sce <- runTSNE(sce,
               name = "TSNE_perplex50",
               perplexity = 50,
               dimred = "PCA")

# Make a custom visualisation using ggcells
ggcells(sce, aes(x = TSNE_perplex50.1, y = TSNE_perplex50.2,
                 colour = SampleName)) +
  geom_point()

# Re-run the algorithm but change the random seed number.
# Do the results change dramatically between runs?
FIXME

# Instead of colouring by SampleName, colour by expression of known cell markers
# CD79A (B cells)
# CST3 (monocytes)
# CD3D (T cells)
# HBA1 (erythrocytes)
FIXME

# Facet these plots by SampleName to better understand where each marker is mostly expressed
FIXME

# Explore different perplexity values (for example 5 and 500)
# Do you get tighter or looser clusters?
FIXME



# Run UMAP ----

# run the UMAP with 50 neighbours
set.seed(123) # set seed for reproducibility
sce <- runUMAP(sce,
               name = "UMAP_neighbors50",
               dimred = "PCA",
               FIXME)

# visualise the resulting UMAP projection (colour cells by sample)
FIXME

# run the UMAP with 5 and 500 neighbours and compare the results
FIXME

# compare the UMAP projection with the t-SNE projections
# would you prefer one over the other?
FIXME
