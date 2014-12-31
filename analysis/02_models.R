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

# Empty model

(mm0 <- glmer(against ~ (1|projetx)+(1|id), data = d, 
      family = binomial))

## Projet level only models

# Type
(mmPtyp <- glmer(against ~ (1|projetx) + (1|id) + typex, data = d,
              family = binomial()))

#Topic
(mmPtop <- glmer(against ~ (1|projetx) + (1|id) + topic, data = d,
                 family = binomial()))

(mmP <- glmer(against ~ (1|projetx) + (1|id) + typex + topic, data = d,
              family = binomial()))


## Individual level only models

# sociodemographic

(mmIsoc <- glmer(against ~ (1|projetx) + (1|id) + agez + sexe + #educ + 
                 actilu, data = d, family = binomial()))

# cultural

(mmIcul <- glmer(against ~ (1|projetx) + (1|id) + regiling, data = d, 
               family = binomial()))

# projet specific
# a35x1 Kenntnis der Empfehlung des Bundesrats
# conx   Kenntnisskala (0-2) f die Vorlage
# impactx1 Schätzung der Auswirkung der Vorlage (auf Person)
# a04   Abstimmungsmodus

(mmIpro <- glmer(against ~ (1|projetx) + (1|id) + a35x + conx + impactx + a04,
              data = d, family = binomial()))




# all predictors

(mmI <- glmer(against ~ (1|projetx) + (1|id) + agez + sexe + educ + actilu *
              revenu + 
              regiling + a35x + conx + impactx + a04 +
              a83 + p02 + p04 + p08, 
              data = d, family = binomial()))

# minimal individual level model

## save all models
models <- list(mm0, mmP)

save(models, file = 'analysis/models.RData') 

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
