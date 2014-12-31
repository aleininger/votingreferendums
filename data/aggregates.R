# Voting Referendums
# R source to create aggregates from data, by projet and scrutin
# Arndt Leininger
# 26 December 2015

# number of referendumss
# number of scrutins
# number of referendum per scrutin (min, max, mean, median)

#load('../../data/referendums.RData')

# by referendum (projet) 
projets <- aggregate(d, by = list(d$projetx), head, n = 1)
projets$samplesize <- aggregate(d$id, by = list(d$projetx), length)[[2]]
projets$against <- aggregate(d$against, by = list(d$projetx), 
                             sum, na.rm = TRUE)[[2]]
projets$against.perc <- (projets$against / projets$samplesize) * 100

# by referendum day (scrutin)
scrutins <- aggregate(d, by = list(d$scrutin), head, n = 1)
scrutins$projets <- aggregate(projets$scrutin, by = list(projets$scrutin), 
                              length)[[2]]

# by types (typex)
types <- aggregate(projets$typex, by = list(projets$typex), length)
names(types) <- c('type', 'freq')

# by topic (topic)
topics <- aggregate(projets$topic, by = list(projets$topic), length)
names(topics) <- c('topic', 'freq')
