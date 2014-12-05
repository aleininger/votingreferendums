rm(list=ls())

setwd('/home/arndt/Dropbox/01 PhD/02 projects/votingreferendums')

ids <- read.csv2('data/win_datasheet.csv', stringsAsFactors = F, 
                 na.strings = ".", dec = ".")
# abs <- read.csv2('data/abstimmungsliste.csv', stringsAsFactors = F, skip = 2, 
#                 na.strings = ".")

names(ids)
head(ids)

################################################################################
################################################################################
# Prepare variables
################################################################################
################################################################################

################################################################################
# create year variable
################################################################################

ids$year <- as.numeric(substring(ids$datum, 7, 10))


################################################################################
# whether gov was 'defeated in vote'
################################################################################

ids$niederlage <- (ids$volk == 1 & ids$br.pos == 2) | 
  (ids$volk == 0 & ids$br.pos == 1)  # indicates whether gov was defeated


################################################################################
# How large was vote share against 
################################################################################

# codes whether yes vote was vote against government
ids$jagegen <- as.numeric(ids$volk == 1 & ids$br.pos == 2)  

# voteshare against governmet
ids$gegen.br.proz <- ids$volkja.proz * ids$jagegen + 
  (100 - ids$volkja.proz) * (1 - ids$jagegen)


# absolute number of people that voted against government reco
# ids$gegen.br <- ids$volkja * ids$jagegen + ids$volknein * (1-ids$jagegen)
# ids$gegen.br.proz <- (ids$gegen.br / ids$berecht)* 100

# ids$fuer.br <- ids$volkja * (1 - ids$jagegen) + ids$volknein * ids$jagegen
# ids$fuer.br.proz <- (ids$fuer.br / ids$berecht)* 100

################################################################################
# referendum & initiative dummy
################################################################################

#referendum dummy
ids$referendum <- 1

# initiative dummy
ids$initiative <- as.numeric(ids$rechtsform == 3)

################################################################################
################################################################################
# Aggregate new variables to different levels
################################################################################
################################################################################

sum.na <- function(x) sum(x, na.rm = T)
mean.na <- function(x) sum(x, na.rm = T)

################################################################################
# referendums & niederlagen
################################################################################

# aggregate

# aggregate by legislatur
niederlagen.l <- aggregate(ids[,c("referendum","niederlage")], by = list(ids$legislatur), 
          FUN = sum.na)
names(niederlagen.l) <- c("legislatur", "referendums", "niederlagen")
niederlagen.l$niederlagen.proz <- (niederlagen.l$niederlagen / 
                                     niederlagen.l$referendums) * 100

# aggregated by year
niederlagen.y <- aggregate(ids[,c("referendum","niederlage")], by = list(ids$year), 
                           FUN = sum.na)
names(niederlagen.y)[1] <- "year"


################################################################################
# relative number of people that voted against government reco
################################################################################

# aggregated by legislatur
aggregate(ids[,"gegen.br.proz"], by = list(ids$legislatur), FUN = mean)

#aggregate(ids[,"gegen.br.proz"], by = list(ids$legislatur), FUN = mean)

#aggregate(ids[,"fuer.br.proz"], by = list(ids$legislatur), FUN = mean)


################################################################################
# number of initiative
################################################################################

initiatives <- aggregate(ids[,c("referendum", "initiative")], 
                         by = list(ids$legislatur), FUN = sum)
names(initiatives) <- c('legislatur','referendums', 'initiatives')
initiatives$initiatives.proz <- (initiatives$initiatives / 
                                   initiatives$referendums) * 100

################################################################################
################################################################################
# Trend analysis
################################################################################
################################################################################

################################################################################
# Referendums
################################################################################

lm(referendums ~ legislatur, data = initiatives[30:49,]) %>% summary
plot(x = initiatives$legislatur, y = initiatives$referendums)

################################################################################
# niederlagen
################################################################################

#by legislatur
lm(niederlagen~legislatur, data = niederlagen.l[30:49,]) %>% summary
plot(x = niederlagen.l$legislatur, y = niederlagen.l$niederlagen)

lm(niederlagen.proz~legislatur, data = niederlagen.l[30:49,]) %>% summary
plot(x = niederlagen.l$legislatur, y = niederlagen.l$niederlagen.proz)

#by year
lm(niederlagen~year, data = niederlagen.y[30:49,]) %>% summary
plot(x = niederlagen.y$year, y = niederlagen.y$niederlagen, )

################################################################################
# mean against government vote (%)
################################################################################

################################################################################
# number of initiatives
################################################################################

lm(initiatives ~ legislatur, data = initiatives) %>% summary
plot(y = initiatives$initiatives, x = initiatives$legislatur)

lm(initiatives.proz ~ legislatur, data = initiatives) %>% summary
plot(x = initiatives$legislatur, y = initiatives$initiatives.proz)



################################################################################
################################################################################
# Plot
################################################################################
################################################################################

# What to plot
# - 
referendums (yearly bar chart), initiatives, niederlagen