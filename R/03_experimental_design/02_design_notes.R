# Experimental-design guide
#
# RCBD: use when each block/replication contains the treatment set according
# to the randomization plan.
#
# CRD: use when experimental units are randomized without a blocking factor.
# Example: aov(Yield ~ Treatment, data = dat)
#
# Factorial: include factor interactions when the design contains combinations
# of factors, e.g. aov(Yield ~ Replication + Variety * Mulching, data = dat).
#
# PBIB: partially balanced incomplete block designs require their correct
# block, replication, treatment and design parameters. Do not substitute an
# ordinary RCBD model. Consult the relevant package documentation and the
# experiment's design sheet before analysis.
#
# This file is explanatory and intentionally does not run a model.
