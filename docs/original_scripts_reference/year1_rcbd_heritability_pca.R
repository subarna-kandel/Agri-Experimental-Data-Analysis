packages <- c("agricolae", "readxl", "doebioresearch", "tidyverse", "variability" )

for (package in packages) {
    if (!requireNamespace(package, quietly = TRUE)) {
        # Install package
    }
}


library(agricolae)
library(readxl)
library (doebioresearch)

#load  1st yearn data
library(readxl)
y1 <- read_excel("data/year_1.xlsx")

#attach dataset

attach(y1)
is.data.frame(y1)
summary_y1 <- summary(y1)
print(summary_y1)
#write out lsd and anova file
 sink("summary_y1.txt")
 print(summary_y1)
 sink()

 Treatment <-as.factor(Treatment)
Replication <- as.factor(Replication)
dim(y1)
length(Treatment)
length(Replication)

#analysis for anova and post hoc test for rcbd design
anova_y1 <- rcbd(y1[4:15], y1$Treatment, y1$Replication, 1)
anova_y1 <- rcbd(y1[4:15], Treatment, Replication, 1)
print(anova_y1)
#write out lsd and anova file
 sink("anovay1.txt")
 print(anova_y1)
 sink()



#test for heritability
#Install the packages
library(variability)

#test for heritability
her_y1 <- gen.var(y1[4:15], y1$Treatment, y1$Replication)

#write out file of heritability

sink("her_y1.txt")
print(her_y1)
sink()

#principle component analysis

pca_y1 <- prcomp(y1, center = TRUE, scale = TRUE)


# # analysis of second year data

# #load  2nd year data

# #attach dataset
# attach(y2)
# is.data.frame(y2)
# summary_y1 <- summary(y1)
# #write out lsd and anova file
#  sink(summary_y2.txt)
#  print(summary_y2.txt)
#  sink()




# Install required packages if not installed
packages <- c("Hmisc", "corrplot", "ggcorrplot")
# Load libraries
library(Hmisc)
library(corrplot)
library(ggcorrplot)


data <- y1[, sapply(y1, is.numeric)]

data <- na.omit(data)

corr_res <- rcorr(as.matrix(data))
corr_mat <- corr_res$r
p_mat <- corr_res$P

sig_levels <- function(p) {
  ifelse(p < 0.001, "***",
         ifelse(p < 0.01, "**",
                ifelse(p < 0.05, "*", "")))
}

sig_labels <- sig_levels(p_mat)

# ÃƒÂ°Ã…Â¸Ã¢â‚¬Å“Ã…â€™ Combine correlation values and significance labels
corr_labels <- matrix(paste0(round(corr_mat, 2), sig_labels),
                      nrow = nrow(corr_mat))

# ÃƒÂ°Ã…Â¸Ã¢â‚¬Å“Ã…Â  Custom color palette: green to blue gradient
col_palette <- colorRampPalette(c("#2E8B57", "#66CDAA", "#20B2AA", "#00CED1", "#4682B4"))(200)

# ÃƒÂ°Ã…Â¸Ã¢â‚¬Å“Ã…Â  Plot using corrplot with custom colors
corrplot(corr_mat, 
         method = "color",
         col = col_palette,   # Apply custom colors
         type = "upper",
         addCoef.col = "black",
         number.cex = 0.8,
         tl.col = "black",
         tl.srt = 45,
         p.mat = p_mat,
         sig.level = 0.05, 
         insig = "blank",
         diag = FALSE)

# ÃƒÂ°Ã…Â¸Ã¢â‚¬Å“Ã…â€™ Add legend for significance levels
legend("bottomleft", legend = c("*** p < 0.001", "** p < 0.01", "* p < 0.05"), 
       cex = 0.8, bty = "n")

# ÃƒÂ°Ã…Â¸Ã¢â‚¬Å“Ã…Â  Plot using ggcorrplot with custom colors
ggcorrplot(corr_mat, 
           method = "square",
           type = "upper",
           p.mat = p_mat, 
           sig.level = 0.05,
           insig = "blank",
           lab = TRUE, 
           lab_size = 3.5,
           tl.cex = 10,
           colors = c("#2E8B57", "#66CDAA", "#4682B4"),  # Custom green-blue colors
           legend.title = "Correlation") +
  theme_minimal() +
  labs(title = "Pearson Correlation Matrix (Green-Blue Gradient)",
       caption = "*** p < 0.001, ** p < 0.01, * p < 0.05")
