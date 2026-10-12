
library(readxl)

v <- read_excel("data/vegetation_data.xlsx")
attach(v)
str(v)
is.data.frame(v)
head(v)
## anova for height
#anova15
ht_anova15<- aov(v$HT15dat~v$replication+v$Treatment) 
summary(ht_anova15)

#anova30
ht_anova30<- aov(v$HT30dat~v$replication +v$Treatment) 
summary(ht_anova30)

#anova45
ht_anova45<- aov(v$HT45dat~v$replication +v$Treatment) 
summary(ht_anova45)

#anova60
ht_anova60<- aov(v$HT60dat~v$replication +v$Treatment) 
summary(ht_anova60)

#anova60
ht_anova60<- aov(v$HT60dat~v$replication+v$Treatment) 
summary(ht_anova60)
#anova75
ht_anova75<- aov(v$HT75dat~v$replication+v$Treatment) 
summary(ht_anova75)


#anovaforstemdiameter 
#anova15
sd_anova15<- aov(v$SD15dat~v$replication+v$Treatment) 
summary(sd_anova15)

#anova30
sd_anova30<- aov(v$SD30dat~v$replication +v$Treatment) 
summary(sd_anova30)

#anova45
sd_anova45<- aov(v$SD45dat~v$replication +v$Treatment) 
summary(sd_anova45)

#anova60
sd_anova60<- aov(v$SD60dat~v$replication +v$Treatment) 
summary(sd_anova60)

#anova60
sd_anova60<- aov(v$SD60dat~v$replication+v$Treatment) 
summary(sd_anova60)
#anova75
sd_anova75<- aov(v$SD75dat~v$replication+v$Treatment) 
summary(sd_anova75)

##plant spreading
#anova15
sg_anova15<- aov(v$spreading15dat~v$replication+v$Treatment) 
summary(sg_anova15)

#anova30
sg_anova30<- aov(v$spreading30dat~v$replication +v$Treatment) 
summary(sg_anova30)

#anova45
sg_anova45<- aov(v$spreading45dat~v$replication +v$Treatment) 
summary(sg_anova45)

#anova60
sg_anova60<- aov(v$spreading60dat~v$replication +v$Treatment) 
summary(sg_anova60)

#anova60
sg_anova60<- aov(v$spreading60dat~v$replication+v$Treatment) 
summary(sg_anova60)
#anova75
sg_anova75<- aov(v$spreading75dat~v$replication+v$Treatment) 
summary(sg_anova75)
##leafanova
#anova15
leaf_anova15<- aov(v$NOL15dat~v$replication+v$Treatment) 
summary(leaf_anova15)

#anova30
leaf_anova30<- aov(v$NOL30dat~v$replication +v$Treatment) 
summary(leaf_anova30)

#anova45
leaf_anova45<- aov(v$NOL45dat~v$replication +v$Treatment) 
summary(leaf_anova45)

#anova60
leaf_anova60<- aov(v$NOL60dat~v$replication +v$Treatment) 
summary(leaf_anova60)

#anova60
leaf_anova60<- aov(v$NOL60dat~v$replication+v$Treatment) 
summary(leaf_anova60)
#anova75
leaf_anova75<- aov(v$NOL75dat~v$replication+v$Treatment) 
summary(leaf_anova75)
