library(maps)
library(ggplot2)
library(rworldmap)
#setwd("~/Documents/blog/import-export/")


ie = read.csv('current-account-balance-usd.csv')

# we'll be using the 2012 numbers
ie$balance = ie$X2012
# fall back to 2011 numbers for countries with no 2012 numbers
ie$balance = ifelse(is.na(ie$X2012),ie$X2011,ie$X2012)

#select the data we'll use and change the ie variable
ie = ie[c("Country.Name","balance")]

#order it by balnce
ie = ie[order(ie$balance),]

#remove rows with missing data
ie = na.omit(ie)

#this is the section that plots the bars
ie.positive = ie[ie$balance>1000000000,]
ie.negative = rev(ie[1:40,])
ie = ie[abs(ie$balance)>10000000000,]
ie.negative = ie[order(ie.negative$balance,decreasing=TRUE),]

ie.to.plot = ie 

#fix margins
mar.default <- c(5,4,4,2) + 0.1
oma = c(0,0,0,0)

par(mar = c(2, 3, 0, 1),oma= c(2,6,0,1))
#comment this out if you only want the map
barplot(ie.to.plot$balance,names.arg=ie.to.plot$Country.Name,horiz=TRUE,cex.names=0.6,las=1,border=NA,cex.axis=0.8,space=0.5)
#text(midpoints, 3, labels=ie$deficit)

# the map, remember to comment the abs() filter to create the map
#sPDF = joinCountryData2Map(ie,joinCode='NAME',nameJoinColumn="Country.Name")
mapCountryData(sPDF,nameColumnToPlot="balance",addLegend='TRUE', colourPalette =c('darkred','khaki','darkgreen'),numCats=500)


