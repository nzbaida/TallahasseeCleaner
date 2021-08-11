rm(list = ls())
setwd("C:/Users/natty/Downloads/")
data <- read.csv("tabula-All CAD 1.1.2006-12.31.2006_Part1.csv")
str(data)
for(i in 1:ncol(data)){
  data[,i] <- as.character(data[,i])
}
click <- which(grepl("Click to search", data[,3]) == TRUE)
data <- data[-click,]
collabel <- which(grepl("Incident #",data[,2]) == TRUE | grepl("Incident #",data[,1]) == TRUE)
data <- data[-collabel,]
location <- which(data[,4] == "Location Name" | data[,7] ==  "Location Name" | data[,6] ==  "Location Name")
data <- data[-location,]
#page <- which(grepl("Page", data[,1]) == TRUE)
#data <- data[-page,]
merged <- which(nchar(data[,3]) > 26)
for(i in merged){
  temp <-strsplit(data[i,3], " ")
  data[i,3] <- paste(temp[[1]][1], temp[[1]][2], temp[[1]][3], temp[[1]][4], temp[[1]][5], sep = " ")
  data[i,4] <- temp[[1]][6]
  data[i,5] <- paste(temp[[1]][7], temp[[1]][8], temp[[1]][9], temp[[1]][10], sep = " ")
}
misaligned <- which(nchar(data[,4]) == 2)
data[misaligned,6] <- data[misaligned,5]
data[misaligned,5] <- data[misaligned,4]
data[misaligned,4] <- data[misaligned,3]
#data[misaligned,3] <- data[misaligned,2]
#misaligned2 <- which(nchar(data[,3]) == 0 & nchar(data[,2]) != 0)
#data[misaligned2,3] <- data[misaligned2,2]
#for(i in misaligned2){
#  data[i,2] <- NA
#}
doubledate <- which(data[,3] == data[,4])
for(i in doubledate){
  data[i,3] <- NA
}
write.csv(data, file = "tabula-All CAD 1.1.2006-12.31.2006_Part1 cleaned.csv")
