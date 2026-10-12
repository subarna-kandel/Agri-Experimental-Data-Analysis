library(factoextra)
library(readxl)
data<- read_excel("data/year_2.xlsx")
attach(data)
data$Treatment <- as.numeric(as.factor(data$Treatment))

prcomp(data, scale. = TRUE)
pca<-prcomp(data, scale. = TRUE)
summary(pca)

#writeout summary of pca
sink("summary_pca.txt")
print(summary(pca))
sink()


fviz_eig(pca)
# Save the plot
pdf("plot.pdf")
fviz_eig(pca)
dev.off()


#Graph  genotypes
fviz_pca_ind(pca,col.ind = "cos2", gradient.cols = c("green", "yellow", "red"), repel = TRUE)

pdf("plot2.pdf")
fviz_pca_ind(pca,col.ind = "cos2", gradient.cols = c("green", "yellow", "red"), repel = TRUE)
dev.off()

#Graph  traits 
fviz_pca_var(pca, col.var = "contrib", gradient.col = c("pink","purple", "blue"), repel = TRUE)
pdf("plot3.pdf")
fviz_pca_var(pca, col.var = "contrib", gradient.col = c("pink","purple", "blue"), repel = TRUE)
dev.off()

# genotypes and traits
fviz_pca_biplot(pca, repel = TRUE, col.var = "red", col.ind = "blue")

pdf("plot3.pdf")
fviz_pca_biplot(pca, repel = TRUE, col.var = "red", col.ind = "blue")
dev.off()


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
