# Identify referendum level variable projetx
# Identify election day variable

library("lme4")

(m1 <- lmer(against ~ (1|projetx), data = d))
summary(m1)
