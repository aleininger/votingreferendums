#setwd('/home/arndt/Dropbox/01 PhD/02 projects/votingreferendums')
#load('data/referendums.RData')

# identify the Minarett-Verbot
#refs[which(refs$anr == '547'),]

# identify the Ausschaffungsinitiative
#refs[which(refs$anr == '552.1'),]

opar <- par(no.readonly = T)
par(mfrow = c(1,2), mai = rep(.5,4), cex = .8)
barplot(height = topics$freq, names.arg = topics$topic, horiz = T)
barplot(height = types$freq, names.arg = types$type)
par(opar)


