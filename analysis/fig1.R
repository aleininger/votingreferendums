# Voting Referendums
# Plot for trends
# Arndt Leininger
# 26 December 2014

################################################################################
# Plot
################################################################################

# Referendums

#subset for plotting
year.p <- year[which(year$year>=1950),]
legislatur.p <- legislatur[which(legislatur$legismitteljahr>=1950),]

m <- lm(niederlagen ~ legismitteljahr, data = legislatur.p)
summary(m)

# Plot
opar <- par(no.readonly=TRUE)

par(pin = c(6, 3))

plot(x = year.p$year, y = year.p$referendums, type="h", lwd = 6, col = 'grey', 
     xlab = '', ylab = '', ylim=c(0,30))
lines(x = year.p$gegen)
lines(x = legislatur.p$legismitteljahr, y = legislatur.p$initiatives, lwd = 2)
points(x = legislatur.p$legismitteljahr, y = legislatur.p$niederlagen,  lwd = 2)
abline(m, lty = 2, lwd = 2)
legend(x = 1950, y = 30, legend = c('Referendums per year', 
                                    'Initiatives per leg. period',
                                    'Lost referendums per leg. period',
                                    'Trend in lost referendums'), 
       lty = c(1,1,0,2), lwd = c(6,2,2,2), col = c("grey","black","black", 'black'),
       pch = c(NA,NA,1), bty = "n")
#par(opar)
