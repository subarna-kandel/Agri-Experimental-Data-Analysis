library(factoextra)
library(readxl)
data<- read_excel("data/year_2.xlsx")
attach(data)
data$Treatment <- as.numeric(as.factor(data$Treatment))

prcomp(data, scale. = TRUE)
pca<-prcomp(data, scale. = TRUE)
summary(pca)

#writeout summary of pca

# Redirect output to a text file
sink("PCA_summaryy2.txt")

# Write summary to the file
summary(pca)

# Stop redirecting output
sink()

#Eigen value visualization (Scree plot)
fviz_eig(pca)
# Save the plot as a PDF file
pdf("plot.pdf")
fviz_eig(pca)
dev.off()


#Graph representing genotypes (Genotypes with similarity are grouped together)
fviz_pca_ind(pca,col.ind = "cos2", gradient.cols = c("green", "yellow", "red"), repel = TRUE)

pdf("plot2.pdf")
fviz_pca_ind(pca,col.ind = "cos2", gradient.cols = c("green", "yellow", "red"), repel = TRUE)
dev.off()

#Graph representing traits (Useful for assessing correlation)
fviz_pca_var(pca, col.var = "contrib", gradient.col = c("pink","purple", "blue"), repel = TRUE)
pdf("plot3.pdf")
fviz_pca_var(pca, col.var = "contrib", gradient.col = c("pink","purple", "blue"), repel = TRUE)
dev.off()

#Biplot of both genotypes and traits
fviz_pca_biplot(pca, repel = TRUE, col.var = "red", col.ind = "blue")

pdf("plot3.pdf")
fviz_pca_biplot(pca, repel = TRUE, col.var = "red", col.ind = "blue")
dev.off()

#R commands for accessing PCA values that were used in plotting these graphs
get_eigenvalue(pca)
get_pca_var(pca)
res.var<-get_pca_var(pca)
res.var$coord
res.var$cor
res.var$cos2
res.var$contrib

get_pca_ind(pca)
res.ind<-get_pca_ind(pca)
res.ind$coord
res.ind$cos2
res.ind$contrib

# WRITE OUT PCA values that were used in plotting these graphs
sink("pca_y1_VALUES.txt")
print(get_eigenvalue(pca))
print(get_pca_var(pca))
print(get_pca_ind(pca))
print(res.ind<-get_pca_ind(pca))
print(res.ind$coord)
print(res.ind$cos2)
print(res.ind$contrib)
sink()


#calculate eigen value and vector
eigen(data.cor)

library(ggplot2)
library(FactoMineR)
library(factoextra)
library(ggrepel)
my_pca<- PCA(data[c(4:14)], graph = FALSE)
geno_name<-data$Treatment

biplot<- fviz_pca_biplot(my_pca, geom = "point",
                         axes = c(1,2),
                         col.var = "black",
                         ggtheme = theme_minimal())+
  geom_text_repel(data = data.frame(my_pca$ind$coord, geno_name),
                  aes(x = Dim.1, y = Dim.2, label = geno_name),
                  size = 3, color = "red")

ggsave("biplot.jpeg", plot = biplot, width = 6, height = 4)
