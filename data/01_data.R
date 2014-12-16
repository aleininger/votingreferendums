# R source to load ESS6 dataset and create data.key
# Arndt Leininger
# 5 December 2015

rm(list=ls())

# set wd, load packages and data
# setwd('/home/arndt/Dropbox/01 PhD/01 Papers/supportDD')  # notebook
setwd('C:/Users/el1/Documents/votingreferendums')  # GESIS

library(foreign)
library(magrittr)
library(knitr)

d <- read.dta('data/ProjetsD_104.dta', convert.dates = T, 
              missing.type = T)

################################################################################
# Cleaning up data
################################################################################

# Recode projetx for Bg Arbeitsgesetz 1998 and 2005, otherwise this leads to
# duplicates

d$projetx <- as.character(d$projetx)

d[d$projetx=="Bg Arbeitsgesetz" & d$annee==1998,"projetx"] <-
  "Bg Arbeitsgesetz 1998"

d[d$projetx=="Bg Arbeitsgesetz" & d$annee==2005,"projetx"] <-
  "Bg Arbeitsgesetz 2005"

d$projetx <- as.factor(d$projetx)

################################################################################
# Data.Key
################################################################################

source('data/documentation/datakey.R')  # creates a complete datakey & subset of relevant vars
# also saves these datakeys in files


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
  


################################################################################
# Save Project
################################################################################

save.image('data/referendums.RData', compress = T)
