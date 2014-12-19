# Identify referendum level variable projetx
# Identify election day variable

library("lme4")
library(arm)
library(lmtest)
library("plm")

(m1 <- lmer(against ~ (1|projetx), data = d))
summary(m1)
display(m1)

(m1 <- glm(against ~ age + projetx, data = d, family = binomial(link = 'logit')))

coeftest(m1, vcov = vcovHC(m1, type = "HC1"))
