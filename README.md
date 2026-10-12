# Agricultural Research Analysis in R

A GitHub-ready library of reusable R templates for agricultural, soil, water, grain, experimental-design, statistical, and spatial/GIS analysis. These scripts are guides: update the paths, column names, treatment codes, and study design to match your own data before running them.

## Main topics

- Data import, inspection, summaries, and data dictionary
- RCBD, CRD-style one-factor comparisons, factorial analysis, and multi-trait ANOVA examples
- Mean comparison, standard error of the mean (SEM), normality checks, Welch two-sample t-tests, and Wilcoxon rank-sum tests
- Correlation matrices and selected-variable correlation plots
- PCA, clustering, multivariate analysis, and multi-year analysis templates
- Soil, groundwater, and grain response workflows
- Excel table joins using a shared sample/laboratory ID
- `sf`-based study-area maps, GPS sampling maps, and random points within polygon boundaries

## Repository layout

```text
R/
  00_setup.R
  01_data_exploration/
  02_anova/
  03_experimental_design/
  04_mean_comparison/
  05_heritability/
  06_correlation/
  07_pca/
  08_multi_year_analysis/
  09_hypothesis_testing/
  10_soil_water_grain/
  11_data_management/
  12_spatial_gis/
  13_visualization/
  14_complete_workflow.R           # one configured end-to-end run
examples/                         # synthetic demonstration data only
docs/
  DATA_DICTIONARY_TEMPLATE.csv
  original_scripts_reference/     # generalized supplied reference scripts
outputs/                          # generated files; not committed by default
```

## Setup and use

1. Install R/RStudio and open this repository as the working directory.
2. Install only the packages required by the script you intend to use. Common packages include:

```r
install.packages(c(
  "readxl", "writexl", "dplyr", "ggplot2", "agricolae",
  "Hmisc", "corrplot", "factoextra", "sf", "ggspatial"
))
```

3. Copy your dataset into a suitable local folder (for example `data/`) or change each script's `data_file` / path setting.
4. Inspect the column names using `names(dat)` and update all selected columns. Never assume that example names such as `Treatment`, `PlantHeight`, `longitude`, or `lab_id` exist in your file.
5. Run individual scripts from the repository root. Example:

```r
source("R/09_hypothesis_testing/01_two_group_tests.R")
source("R/10_soil_water_grain/01_correlation_matrix_and_pair.R")
source("R/12_spatial_gis/01_study_area_map.R")
```

For a single end-to-end analysis, edit the settings at the top of
`R/14_complete_workflow.R` (`data_file`, `group_col`, `block_col`, and
`primary_response`) and run:

```r
source("R/14_complete_workflow.R")
```

The focused scripts include `R/06_correlation/02_grouped_soil_water_correlation.R`
for overall and treatment-wise correlations,
`R/07_pca/02_multivariate_analysis.R` for PCA/clustering/MANOVA/CCA/factor
analysis, `R/10_soil_water_grain/03_grain_quality_tests.R` for grain-style
two-group tests and boxplots, and
`R/10_soil_water_grain/04_response_anova.R` for repeated soil/water/grain
response ANOVA, Tukey HSD, and SEM output.

## Statistical and spatial cautions

- Select the statistical model from the actual sampling and experimental design. Observations from blocks, repeated measures, paired samples, or nested sampling may require a model other than a simple one-way ANOVA or two-sample test.
- A Shapiro-Wilk test does not by itself determine which inferential test should be used. Inspect residuals and plots, sample size, independence, variance structure, and the scientific question.
- SEM describes uncertainty in an estimated mean; it is not the standard deviation of observations.
- Correlation is not evidence of causation. Spearman correlation is rank-based; the plotted linear trend is only a visual aid and is not itself a Spearman fit.
- For spatial work, verify coordinate reference systems, coordinate column names, boundary validity, and the intended sampling method. `st_sample()` generates locations inside polygon geometry; it is different from sampling polygon rows.
- Multi-response loops can produce many p-values. Consider multiplicity, effect sizes, confidence intervals, and pre-specified hypotheses.

## Data and validation status

`examples/agricultural_example.csv` is synthetic and must not be reported as real research data. `docs/original_scripts_reference/` stores generalized, purpose-named versions of the user-supplied R scripts for reference; it may still include mistakes or incomplete code. The cleaned templates are reorganized examples and have **not been validated against the original study datasets**. Verify output and assumptions before using results in a thesis, report, or publication.

Only publish datasets you have permission to share. Add a repository license only after deciding what reuse permissions you intend to grant.
