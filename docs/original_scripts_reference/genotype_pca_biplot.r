library(ggplot2)
library(FactoMineR)
library(factoextra)
library(ggrepel)
my_pca<- PCA(data[c(3:19)], graph = FALSE)
geno_name<-data$Genotype

biplot<- fviz_pca_biplot(my_pca, geom = "point",
                         axes = c(1,2),
                         col.var = "black",
                         ggtheme = theme_minimal())+
  geom_text_repel(data = data.frame(my_pca$ind$coord, geno_name),
                  aes(x = Dim.1, y = Dim.2, label = geno_name),
                  size = 3, color = "red")

ggsave("biplot.jpeg", plot = biplot, width = 6, height = 4)
