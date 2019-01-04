library(lattice)
library(car)

path="https://archive.ics.uci.edu/ml/machine-learning-databases/yeast/yeast.data"
yeast=read.table(url(path),col.names = c("Sequence Name","mcg","gvh","alm","mit","erl","pox","vac","nuc","class"))
head(yeast)
str(yeast)

#Visually are the means different?
boxplot(nuc ~ class,yeast )
#ANOVA on Nuc and Class (Independent). (H0) There no difference between mean of Nuc across different classes
yeastAnova =aov(yeast$nuc ~ yeast$class , yeast)
#If P-value is greater than 0.05 then we accept the Ho
summary(yeastAnova)
#P-Value is less than 0.05 hence we reject Ho. We then need to establish which class is showing the difference using a hoc test

#test for homogeneity so we know which hoc test to run
leveneTest(yeast$nuc, yeast$class, center = mean)
#the p-value is less than 0.05 so we reject Ho that the variances between the means are equal. Data is statistically significantly different. 
#sample is heteregenous

#Significantly different Class Mean?
tuk = TukeyHSD(yeastAnova)
tuk
plot(tuk)
##The following classes are significantly different from others:
    #NUC-MIT
    #NUC-ME3
    #NUC-CYT
