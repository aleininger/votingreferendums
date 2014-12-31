# R source to load VoxIt data and create data.key
# Arndt Leininger
# 25 December 2015

rm(list=ls())

# set wd, load packages and data
setwd('/home/arndt/Dropbox/01 PhD/02 projects/votingreferendums')  # notebook
# setwd('C:/Users/el1/Documents/votingreferendums')  # GESIS

library(foreign)
library(magrittr)
library(car)

d <- read.dta('data/ProjetsD_104.dta', convert.dates = T, 
              missing.type = T)

# load('data/referendums.RData')

################################################################################
# Data.Key
################################################################################

source('data/documentation/datakey.R')  # creates a complete datakey & 
# subset of relevant vars
# also saves these datakeys in files


################################################################################
# aggregate by projet
################################################################################

# a <- aggregate(d[, c('projetx', 'typex', 'themex')], by = list(d$projetx), 
#               head, n = 1)

# a[which(a$typex == 'null'),]

################################################################################
# Cleaning up data
################################################################################

# Drop non-voters

d <- subset(d, a01 == 'Ja')

# drop Arbeitsgesetz 1996 because government issued no vote recommendation
d <- d[which(!(d$projetx == '\xc4nderung Bg Arbeitsgesetz' & d$annee == 1996)), ]

# Recode projetx for Bg Arbeitsgesetz 1998 and 2005, otherwise this leads to
# duplicates

d$projetx <- as.character(d$projetx)

d[d$projetx=="Bg Arbeitsgesetz" & d$annee==1998,"projetx"] <-
  "Bg Arbeitsgesetz 1998"

d[d$projetx=="Bg Arbeitsgesetz" & d$annee==2005,"projetx"] <-
  "Bg Arbeitsgesetz 2005"

d$projetx <- as.factor(d$projetx)


################################################################################
# Recoding variables
################################################################################

## Identifier variables

d$id <- factor(d$id)
d$scrutin <- factor(d$scrutin)

## Aggregate level

# typex: change to English and make obligatory referendum the base category
d$typex <- recode(d$typex, "'Obligatorisches Referendum' = 
                  'Obligatory Referendum'; 'Referendum' = 
                  'Facultative Referendum'; 'null' = 'Counter-Proposal'")

d$typex <- factor(d$typex, levels(d$typex)[c(4,2,1,3)])

# reduce categories of theme to 'topics'
d$topic <- car::recode(d$themex, "c('Aussenpolitik', 'Europsche Union',
  'Verteidigung', 'Frieden') = 'Foreign Policy & Defense';
  c('Verkehrspolitik', 'Energiepolitik', 'Umwelt', 'Wohnungswesen', 
  'Raumplanung', 'fentliche Dienste') = 'Transport & Environment';
  c('Kultur', 'Bildung', 'Forschung', 'Medien') = 'Culture';
  c('Strafrecht', 'Rechte', 'Abtreibung', 'Institutionen') = 'Law & Institutions';
  c('Familienpolitik', 'Pension', 'Gesundheit', 'Arbeitslosigkeit', 'Drogen',
  'Arbeitsmarkt') = 'Social Policy'; 
  c('KonsumentInnenschutz', 'Wirtschaftsordnung', 'Landwirtschaft',
  'Subventionen', 'Finanzen', 'Steuern', 'Steuern auf den Verkehr') =  
  'Economic Policy  & Finances'")

## Individual level

d$agez <- as.numeric(scale(d$age))

# regiling: make French Germans base category, drop 'k.A.'

# a35x1 Kenntnis der Empfehlung des Bundesrats
d$a35x <- factor(d$a35x, exclude = c('wn', 'k.A.'))  # drop wn and k.A.
# what is 'frei'?

# impactx1 Schätzung der Auswirkung der Vorlage (auf Person)
# why is this numeric?

# a04   Abstimmungsmodus
d$a04 <- factor(d$a04, exclude = c('wn', 'k.A.'))  # drop wn and k.A.
# difference between Urne and postal vote?

# a22 Vertrauen in die Regierung
d$a22 <- factor(d$a22, exclude = c('wn', 'k.A.'))  # drop wn k.A.

# a83 Schwierigkeit sich eine Meinung zu bilden (generell)
# dummy
# drop wn k.A.
d$a83 <- factor(d$a83, exclude = c('wn', 'k.A.'))

# actilu Erwerbstätigkeit
# dummy
d$actilu <- factor(d$actilu, exclude = 'k.A.')  # drop k.A.

# educ Schulbildung (umfasst auch Hochschule, ordinal)
d$educ <- factor(d$educ, exclude = 'k.A.')  # drop k.A.

# p04 lr self-placement last two surveys only distinguished 
# between left, middle, right

# sexe
d$sexe <- factor(d$sexe, exclude = 'k.A.')  # drop k.A.

# p08 Interesse für Politik
d$p08 <- factor(d$p08, exclude = c('wn', 'k.A.')  # drop wn, k.A.

# revenu Haushaltseinkommen
d$revenu <- factor(d$revenue, exclude = c('wn', 'k.A.')  # drop wn, k.A.
                    
################################################################################
# Addings variables
################################################################################

# was the respondent's reported vote choice 
# a02x
# contrary to the government issued vote recommendation
# motcfx

d <- within(d, {
  
  against <- (a02x == 'Ja' & motcfx == 'Nein') |
             (a02x == 'Nein' & motcfx == 'Ja')
})

# numeric level of education

d$educn <- as.numeric(d$educ)


# identification with one of Bundesrat parties, based on
# p02 Parteiidentifizierung: Recodierung zu PI mit Bundesratspartei

#zauberformel <- c()

#d$pid <- d$p02 %in% zauberformel

# Prozent der Bundesratparteien, die Zustimmung empfehlen

################################################################################
# Aggregates
################################################################################

source('data/aggregates.R')

################################################################################
# Load Official referendum data
################################################################################

source('data/02_data.R')

################################################################################
# Save Project
################################################################################

save.image('data/referendums.RData', compress = T)
