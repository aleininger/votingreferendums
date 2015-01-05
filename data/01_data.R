# R source to load VoxIt data and create data.key
# Arndt Leininger
# 25 December 2015

rm(list=ls())

# set wd, load packages and data
setwd('/home/arndt/Dropbox/01 PhD/02 projects/votingreferendums')  # notebook
setwd('C:/Users/a.leininger/Dropbox/01 PhD/02 Projects/votingreferendums') #Hertie
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
originalsize <- dim(d)[1]
d <- subset(d, a01 == 'Ja')

# drop voters who casted an empty ballot
voterssize <- dim(d)[1]
d <- subset(d, a02x != 'Leer' | is.na(a02x))

# drop Arbeitsgesetz 1996 because government issued no vote recommendation
yesnovoterssize <- dim(d)[1]
d <- d[which(!(d$projetx == '\xc4nderung Bg Arbeitsgesetz' & d$annee == 1996)), ]
finalsize <- dim(d)[1]
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

# date of vote
#apply(d[1:2,c('jour', 'mois', 'annee')], 1, function(x) class(x))


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

# reduce categories of topic further into
# domestic
# foreign
# immigration

d$topicr <- recode(d$topic, "c('Transport & Environment', 'Culture',
                   'Law & Institutions', 'Social Policy', 
                   'Economic Policy  & Finances') = 'Domestic Politics'")

# how many governing parties recommend voting for the government's position?


# PRD/FDP - Free Democratic Party
# PSS/SPS - Social Democratic Party
# PDC/CVP - Christian Democratic People's Party
# PBD/BDP - Conservative Democratic Party of Switzerland
# UDC/SVP - Swiss People's Party

# vote recommendations
# motpbdx   Parole der Bürgerlich-Demokratische Partei
d$motpbd <- 0
d$motpbd[which(as.character(d$motpbdx) == as.character(d$motcfx))] <- 1

# motpdcx   Parole der Christlichdemokratischen Volkspartei
d$motpdc <- 0
d$motpdc[which(as.character(d$motpdcx) == as.character(d$motcfx))] <- 1

# motpsx   Parole der Sozialdemokratischen Partei
d$motps <- 0
d$motps[which(as.character(d$motpsx) == as.character(d$motcfx))] <- 1

# motudcx   Parole der Schweizerischen Volkspartei
d$motudc <- 0
d$motudc[which(as.character(d$motudcx) == as.character(d$motcfx))] <- 1

# motplrx   Parole der FDP Die Liberalen
# motprdx   Parole der Freisinnig-Demokratischen Partei
d$motplr <- 0
d$motplr[which(as.character(d$motplrx) == as.character(d$motcfx))] <- 1
d$motplr[which(as.character(d$motprdx) == as.character(d$motcfx))] <- 1

# calculate proportion of Bundesrat parties issuing vote recommendation
# in concordance with motcfx

cfvars <- c('motpbd', 'motpdc', 'motps', 'motudc','motplr')

d$motpcf <- numeric(length(d$motcfx))
d$motpcf[which(d$annee < 2009)] <- rowSums(d[which(d$annee < 2009), cfvars])/4
d$motpcf[which(d$annee > 2008)] <- rowSums(d[which(d$annee > 2008), cfvars])/5

## Individual level

d$agez <- as.numeric(scale(d$age))

# regiling: drop 'k.A.', English labels
d$regiling <- factor(d$regiling, labels = c('Swiss-German','Romandie', 
                                            'Italian Switzerland'), 
                     exclude = 'k.A.')

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
d$educn <- as.numeric(d$educ)  # numeric level of education
d$uni <- (d$educ == 'Universit\xe4t, Hochschule')

# p04 lr self-placement last two surveys only distinguished 
# between left, middle, right

# sexe
d$sexe <- factor(d$sexe, labels = c('male', 'female'), exclude = 'k.A.')  
# drops k.A. and relabels

# p08 Interesse für Politik
# exclude unused categories and reorder
d$p08 <- factor(d$p08, levels = levels(d$p08)[c(4,3,2,1)], exclude = c('wn', 'k.A.'))  # drop wn, k.A.
d$p08n <- as.numeric(d$p08)

# revenu Haushaltseinkommen
d$revenu <- factor(d$revenu, exclude = c('wn', 'k.A.'))  # drop wn, k.A.
                   
# conx  Knowledge scale (0-2) for the project
d$conx <- factor(d$conx, labels = c('No knowledge', 'Knows title or content', 
                                    'Knows title and content'))
# a numeric version
d$conxn <- as.numeric(d$conx)-1
                    
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

# identification with one of Bundesrat parties, based on
# p02 Parteiidentifizierung
#levels(d$p02)

# Bundesrat parties before founding of BDP
bundesrat1 <- c('PRD/FDP', 'PSS/SPS', 'PDC/CVP', 'UDC/SVP')


#Bundesrat parties after 10 December 2008 whenUeli Maurer from the SVP/UDC
# became federal councillor and  Eveline Widmer-Schlumpf of BDP stayed on
bundesrat2 <- c(bundesrat1, 'PBD/BDP')

d$pid <- logical(length(d$p02))

# Bundesrat parties before founding of BDP
d$pid[which(d$annee < 2009)] <- d$p02[which(d$annee < 2009)] %in% bundesrat1 # before BDP formed and became part of 
  # Bundesrat

#Bundesrat parties after 10 December 2008 when Ueli Maurer from the SVP/UDC
# became federal councillor
d$pid[which(d$annee > 2008)] <- d$p02[which(d$annee > 2008)] %in% bundesrat2

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
