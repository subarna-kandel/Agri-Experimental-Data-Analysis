# Guide for genetic variance / heritability workflows.
# The correct method depends on the breeding design, variance components,
# number of environments/years, and the definition of heritability required.
#
# Your original scripts used variability::gen.var() for genetic variance
# summaries. Review the package documentation and match the function inputs
# to the design before applying it to real data.
#
# Example starting point (adapt to the actual dataset):
# install.packages("variability")
# library(variability)
# dat <- read.csv("data/genotype_trial.csv")
# result <- gen.var(dat[trait_columns], dat$Treatment, dat$Replication)
# print(result)
#
# Do not interpret broad-sense or narrow-sense heritability interchangeably.
