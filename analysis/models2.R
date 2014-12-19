# Individual
# age - Alter in Jahren
# regiling
# a35x1 Kenntnis der Empfehlung des Bundesrats
# conx   Kenntnisskala (0-2) f die Vorlage
# impactx1 Schätzung der Auswirkung der Vorlage (auf Person)
# a04   Abstimmungsmodus
# a22 Vertrauen in die Regierung
# a83 Schwierigkeit sich eine Meinung zu bilden (generell)
# actilu Erwerbstätigkeit
# educ Schulbildung (umfasst auch Hochschule, ordinal)
# p02 Parteiidentifizierung: Recodierung zu PI mit Bundesratspartei
# p04 lr self-placement not usable because last two surveys only distinguished 
# between left, middle, right
# sexe
# p08 Interesse für Politik
# regiling Sprachregionen: Romandie, Deutschschweiz, Italienische Schweiz
# (Romandie als Basis)
# revenu Haushaltseinkommen

# Projet
# typex (recode to obligatory as base)
# themex (simpliyf?) Themenreduktion auf Basis der Zahlencodes moeglich
# Prozent der Bundesratparteien, die Zustimmung empfehlen

library("plyr")

d2 <- subset(d, a01 == 'Ja')

#d2 <- ddply(d2, .(age), transform, agex = age - mean(age))
d2$agec <- d2$age - mean(d2$age)
d2$ages <- d2$age / sd(d2$age)
d2$agez <- scale(d2$age)

d2$id <- factor(d2$id)
d2$scrutin <- factor(d2$scrutin)

library("lme4")
(mm0 <- glmer(against ~ (1|scrutin/projetx)+(1|scrutin/id), data = d2, 
      family = binomial))

(m1 <- glmer(against ~ agec + (1|scrutin/projetx)+(1|scrutin/id), data = d2, 
             family = binomial, nAGQ = 1))

(m1a <- glmer(against ~ agez + (1|id) + (1|projetx), data = d2, 
             family = binomial, nAGQ = 1))

(m1b <- glmer(against ~ agez + sexe + regiling + (1|scrutin) + (1|projetx), 
              data = d2, family = binomial, nAGQ = 1))

(m1c <- glmer(against ~ agez + typex + themex + (1|scrutin) + (1|projetx), data = d2, 
              family = binomial, nAGQ = 1))
