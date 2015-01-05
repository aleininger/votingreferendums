# prepare variables for subsetting
projetvariables <- c('type', 'topicr', 'motpcf')
individualvariables <- c('agez', 'sexe', 'uni', 'conx', 'actilu', 'regiling')
levelvariables <- c('projetx', 'id')

# temporary data
tmpdat <- d[, c(projetvariables, individualvariables, levelvariables)]

summary(d$agez)

jvalues <- with(d, seq(from = min(agez), to = max(agez), length.out = 50))

# calculate predicted probabilities and store in a list
pp <- lapply(jvalues, function(j) {
  tmpdat$agez <- j
  predict(mmF, newdata = tmpdat, type = "response")
})

# average marginal predicted probability across a few different Lengths of
# Stay
sapply(pp[c(1, 20, 40, 60, 80, 100)], mean)


# get the means with lower and upper quartiles
plotdat <- t(sapply(pp, function(x) {
  c(M = mean(x), quantile(x, c(0.25, 0.75)))
}))

# add in LengthofStay values and convert to data frame
plotdat <- as.data.frame(cbind(plotdat, jvalues))

# better names and show the first few rows
colnames(plotdat) <- c("PredictedProbability", "Lower", "Upper", "LengthofStay")
head(plotdat)

# plot average marginal predicted probabilities
ggplot(plotdat, aes(x = LengthofStay, y = PredictedProbability)) + geom_line() +
  ylim(c(0, 1))

plot(plotdat$LengthofStay, plotdat$PredictedProbability, type='l', ylim = c(0,1))