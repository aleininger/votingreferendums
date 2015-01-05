#setwd('/home/arndt/Dropbox/01 PhD/02 projects/votingreferendums')
#load('data/referendums.RData')

# identify the Minarett-Verbot
#refs[which(refs$anr == '547'),]

# identify the Ausschaffungsinitiative
#refs[which(refs$anr == '552.1'),]

opar <- par(no.readonly = T)
par(mar = c(2,10,2,2))
barplot(height = topics$freq, names.arg = topics$topic, horiz = T, las = 1,
        cex.names = .8)
par(opar)
par(mar = c(2,2,2,2))
barplot(height = types$freq, names.arg = types$type, cex.names = .8)
par(opar)


