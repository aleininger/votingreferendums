# R source to create dataKey from VoxIt cumulative file
# Arndt Leininger
# 5 December 2015

# library(magrittr)

# produce a data key
dataKey <- data.frame(varName=names(d), varLabel=attr(d, "var.labels"), 
                      stringsAsFactors = F)
write.csv(dataKey, 'data/documentation/dataKey.csv')

# search through datakey
# grep('varname', dataKey$varName) %>% dataKey[.,]

# identify relevant variables
# create a data.frame that contains all variables that we will probably use in
# the initiatal analysis
relevantVars <- c(1,   # Stimmverhalten der Teilnehmenden
                  2,   # Stimmverhalten der Nicht-Teilnehmenden
                  27,  # Anzahl leere Stimmen (Was ist das genau?)
                  28,  # cannonx - Anzahl Kantone, die die Vorlage abgelehnt haben
                  29,  # canouix - Anzahl Kantone, die die Vorlage angenommen haben
                  31,  # dannonx - Anzahl Halbkantone, die die Vorlage abgelehnt haben
                  32,  # danouix - Anzahl Halbkantone, die die Vorlage angenommen haben
                  33,  # decx - Abstimmungsentscheid zur Vorlage
                  36,  # motcfx   Empfehlung des Bundesrates
                  51,  # nonx - Anzahl Nein-Stimmen in Prozent
                  52,  # nulsx - Ung\xfcltige Stimmen
                  53,  # ouix - Anzahl Ja-Stimmen in Prozent
                  54,  # partx - Teilnahme in Prozent
                  55,  # projetx - Zur Abstimmung vorgelegte Vorlage
                  56,  # themex - Thema der Vorlage
                  57,  # typex - Art der Vorlage
                  58,  # a01 - Teilnahme an Abstimmung
                  59,  # a04 - Abstimmungsmodus
                  82,  # annee - Jahr der Abstimmung
                  83,  # canton - Kanton
                  91,  # id - Identifizierungsnummer
                  93,  # jour - Tag der Abstimmung
                  117, # nombre - Anzahl der zur Abstimmung vorgelegten Vorlagen
                  129, # regiling - Sprachregionen
                  144, # sexe - Geschlecht des Befragten
                  169  # weight - Weighting variable
)

# mark relevant variables and type
dataKey$relevant <- F  # create relevant logical col
dataKey$type <- ''  # create a col describing type of variable

dataKey[relevantVars, 'relevant'] <- T  # mark relevant variables

dataKeySub <- subset(dataKey, relevant)  # create subset key of relevant vars

# save subset datakey
write.csv(dataKeySub, 'data/documentation/data_key_sub.csv')

# drop relevantVars
rm(relevantVars)
