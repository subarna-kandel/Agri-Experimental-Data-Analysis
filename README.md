# Agricultural Research Analysis in R

A GitHub-ready library of reusable R templates for agricultural, soil, water, grain, experimental-design, statistical, and spatial/GIS analysis. These scripts are guides: update the paths, column names, treatment codes, and study design to match your own data before running them.

This root README combines the guidance from the README files located in
`examples/README.md` and `docs/original_scripts_reference/README.md`. The
original README files are kept in their respective directories so that the
same guidance remains available next to the files it describes.

If you have other scripts related to agricultural analysis, or would like to
correct mistakes or update existing scripts, you are welcome to contribute.

## Setup and use

This repository includes the R scripts I used and uploaded as a reference for
students conducting agricultural research. The codes are divided by purpose in
the `R/` directory for easier use. These scripts were cleaned from my original
scripts, which are kept in `docs/original_scripts_reference/`. You may use them
as a starting point for your own research. Some code may not work as expected
because it was uploaded directly from my computer. If you encounter a problem
or need help, contact me at mail@subarnakandel.com.np



## Data and validation status

`examples/agricultural_example.csv` is synthetic and must not be reported as real research data. `docs/original_scripts_reference/` stores generalized, purpose-named versions of the user-supplied R scripts for reference; it may still include mistakes or incomplete code. The cleaned templates are reorganized examples and have **not been validated against the original study datasets**. Verify output and assumptions before using results in a thesis, report, or publication.


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
outputs/                          # output files (not committed and pushed to github)
```

## Example data (`examples/`)

The file `examples/agricultural_example.csv` contains **synthetic illustrative
values** created to demonstrate code structure. It is not real experimental
data and must not be cited or interpreted as research findings.

The example file is not guaranteed to represent a valid randomized layout for
every analysis. Replace it with data from an experiment whose design and
treatment allocation are known before drawing scientific conclusions. The
source README for this material is
[`examples/README.md`](examples/README.md).

## Original scripts reference (`docs/original_scripts_reference/`)

This directory contains the supplied reference scripts with purpose-based
filenames. Personal computer paths, usernames, thesis-directory names, and
study-specific place names have been removed. The analysis steps and package
choices are otherwise retained as closely as possible.

Replace the representative paths in these scripts with files available in
your own project:

- `data/*.csv` for CSV input tables
- `data/*.xlsx` for Excel input tables
- `data/study_area_boundary.shp` for a study-area boundary
- `data/land_use_raster.tif` for a land-use raster
- `outputs/` for generated tables, figures, and reports

These scripts are reference material and may still contain different expected
column names, experimental designs, or package requirements. Inspect the data
import and model settings before running a script. The cleaned, maintained
versions for routine use are in the repository's `R/` directory. The source
README for this material is
[`docs/original_scripts_reference/README.md`](docs/original_scripts_reference/README.md).
