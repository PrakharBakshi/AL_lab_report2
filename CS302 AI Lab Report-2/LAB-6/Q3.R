library(mclust)           
data = read.table("Desktop/CS302 AI Lab Report-2/LAB-6/2020_em_clustering.csv",sep = ',')
a = vector()
for (i in data){
  a = c(a, i)
}
model <- Mclust(a,G=2 )
summary(model)
plot(model, what = "classification")