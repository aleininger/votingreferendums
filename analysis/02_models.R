# Individual

## sociodemographic
# age - Alter in 
# sexe
# educ Schulbildung (umfasst auch Hochschule, ordinal)
# actilu Erwerbstätigkeit
# revenu Haushaltseinkommen

## cultural
# regiling Sprachregionen: Romandie, Deutschschweiz, Italienische Schweiz
# (Romandie als Basis)

## projet specific
# a35x1 Kenntnis der Empfehlung des Bundesrats
# conx   Kenntnisskala (0-2) f die Vorlage
# impactx1 Schätzung der Auswirkung der Vorlage (auf Person)
# a04   Abstimmungsmodus

## political
# a83 Schwierigkeit sich eine Meinung zu bilden (generell)
# p02 Parteiidentifizierung: Recodierung zu PI mit Bundesratspartei
# p04 lr self-placement last two surveys only distinguished 
#  between left, middle, right
# p08 Interesse für Politik

# Projet
# typex (recode to obligatory as base)
# themex (simpliyf?) Themenreduktion auf Basis der Zahlencodes moeglich
# Prozent der Bundesratparteien, die Zustimmung empfehlen

library("lme4")

# load('analysis/modelsPaper.RData')

# Empty model

(mm0 <- glmer(against ~ (1|projetx)+(1|id), data = d, 
      family = binomial))

## Projet level only models

# Type
(mmPtyp <- glmer(against ~ (1|projetx) + (1|id) + typex, data = d,
              family = binomial()))

# Topic (reduced categories)
(mmPtop <- glmer(against ~ (1|projetx) + (1|id) + topicr, data = d,
                 family = binomial()))

# Governing Party Paroles
(mmPpcf <- glmer(against ~ (1|projetx) + (1|id) + motpcf, data = d,
                 family = binomial()))

# full projet-level model (does not converge if topicr included)
(mmP <- glmer(against ~ (1|projetx) + (1|id) + typex + motpcf, 
              data = d, family = binomial()))


## Individual level only models

# sociodemographic
(mmIsoc <- glmer(against ~ (1|projetx) + (1|id) + agez + sexe + uni, 
                 data = d, family = binomial()))

# cultural
(mmIcul <- glmer(against ~ (1|projetx) + (1|id) + regiling, data = d, 
               family = binomial()))

# projet specific
# conx   Kenntnisskala (0-2) f die Vorlage
(mmIpro <- glmer(against ~ (1|projetx) + (1|id) + conx,
              data = d, family = binomial()))

# full individual level model
(mmI <- glmer(against ~ (1|projetx) + (1|id) + agez + sexe + uni +
              regiling +
              conx,
              data = d, family = binomial()))


# all predictors
start.time <- Sys.time()
(mmF <- glmer(against ~ (1|projetx) + (1|id) + agez + sexe + uni + 
              regiling +
              conx + 
              typex + motpcf, 
              data = d, family = binomial(), 
              control = glmerControl(optimizer = "bobyqa")))
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken

# minimal individual level model

## save all models
modelsPaper <- c('mmP','mmI', 'mmF')

models <- c('mm0', 'mmPtyp', 'mmPtop', 'mmPpcf', 'mmP', 
            'mmIsoc', 'mmIcul', 'mmIpro')

save(list = modelsPaper, file = 'analysis/modelsPaper.RData')
save(list = models, file = 'analysis/models.RData') 

# other models
# (m1 <- glmer(against ~ agec + (1|scrutin/projetx)+(1|scrutin/id), data = d, 
#              family = binomial, nAGQ = 1))
# 
# (m1a <- glmer(against ~ agez + (1|id) + (1|projetx), data = d, 
#              family = binomial, nAGQ = 1))
# 
# (m1b <- glmer(against ~ agez + sexe + regiling + (1|scrutin) + (1|projetx), 
#               data = d, family = binomial, nAGQ = 1))
# 
# (m1c <- glmer(against ~ agez + typex + themex + (1|scrutin) + (1|projetx), 
#               data = d, family = binomial, nAGQ = 1))
