# rm(list=ls())

# setwd('/home/arndt/Dropbox/01 PhD/02 projects/votingreferendums')  # laptop
# setwd('C:/Users/a.leininger/Dropbox/01 PhD/02 Projects/votingreferendums')  # Hertie

ids <- read.csv2('data/win_datasheet.csv', stringsAsFactors = F, 
                 na.strings = ".", dec = ".")

# abs <- read.csv2('data/abstimmungsliste.csv', stringsAsFactors = F, skip = 2, 
#                 na.strings = ".")

################################################################################
################################################################################
# Prepare variables
################################################################################
################################################################################

################################################################################
# Change identifier anr to factor 
################################################################################

ids$anr <- factor(ids$anr)

################################################################################
# create year variables
################################################################################

ids$year <- as.numeric(substring(ids$datum, 7, 10))

ids$legismitteljahr <- as.numeric(substring(ids$legisjahr, 1, 4)) + 2 

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

# new type variable
ids$typ <- factor(ids$rechtsform, levels = unique(ids$rechtsform), labels = 
                  c('Obligatory Referendum', 'Facultative Referendum', 
                    'Initiative', 'Counter-Proposal'))

#referendum dummy
ids$referendum <- 1

# initiative dummy
ids$initiative <- as.numeric(ids$rechtsform == 3)

################################################################################
# subset to referendums in dataset
################################################################################

refs <- subset(ids, year > 1980 & year < 2011)

################################################################################
################################################################################
# Aggregate new variables to different levels
################################################################################
################################################################################

################################################################################
# number of referendums & initiatives
################################################################################

# by legislatur
initiatives <- aggregate(ids[,c("referendum", "initiative")], 
                         by = list(ids$legislatur), FUN = sum)
names(initiatives) <- c('legislatur','referendums', 'initiatives')
initiatives$initiatives.proz <- (initiatives$initiatives / 
                                 initiatives$referendums) * 100

initiatives <- cbind(initiatives, aggregate(ids[,"legismitteljahr"], 
                                            by = list(ids$legislatur), 
                                            FUN = mean)[,'x'])
names(initiatives)[5] <- 'legismitteljahr'                     

legislatur <- initiatives
rm(initiatives)

# by year
initiatives <- aggregate(ids[,c("referendum", "initiative")], 
                         by = list(ids$year), FUN = sum)
names(initiatives) <- c('year','referendums', 'initiatives')
initiatives$initiatives.proz <- (initiatives$initiatives / 
                                 initiatives$referendums) * 100

year <- initiatives
rm(initiatives)


################################################################################
# referendums & niederlagen
################################################################################

# aggregate

# aggregate by legislatur
niederlagen.l <- aggregate(ids[,c("referendum","niederlage")], by = list(ids$legislatur), 
                           FUN = sum, na.rm = T)
names(niederlagen.l) <- c("legislatur", "referendums", "niederlagen")
niederlagen.l$niederlagen.proz <- (niederlagen.l$niederlagen / 
                                   niederlagen.l$referendums) * 100

legislatur <- cbind(legislatur,niederlagen.l[,3:4])
rm(niederlagen.l)

# aggregated by year
niederlagen.y <- aggregate(ids[,c("referendum","niederlage")], by = list(ids$year), 
                           FUN = sum, na.rm = T)
names(niederlagen.y) <- c("year", "referendums", "niederlagen")
niederlagen.y$niederlagen.proz <- (niederlagen.y$niederlagen /
                                   niederlagen.y$referendums) * 100

year <- cbind(year, niederlagen.y[, 3:4])
rm(niederlagen.y)