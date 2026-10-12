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
