# R source to create dataKey from VoxIt cumulative file
# Arndt Leininger
# 5 December 2015

# library(magrittr)

# produce a data key
dataKey <- data.frame(varName=names(d[,1:174]), varLabel=attr(d, "var.labels"), 
                      stringsAsFactors = F)
write.csv(dataKey, 'data/documentation/dataKey.csv')

# search through datakey
# grep('varname', dataKey$varName) %>% dataKey[.,]

# identify relevant variables
# create a data.frame that contains all variables that we will probably use in
# the initiatal analysis
relevantVars <- c(1,   # Stimmverhalten der Teilnehmenden
                  3,   # a31x - Kenntnis des Vorlagentitels
                  4,   # a32x - Kenntnis der Vorlage in den Einzelheiten
                  6,   # a34x -
                  7,   # a35x - 
                  8,   # a84x - 
                  9,
                  10,
                  11,
                  12,
                  30,  # conx - Kenntnisskala (0-2) f die Vorlage, basiert auf
                       # a31x und a32x
                  33,  # decx - Abstimmungsentscheid zur Vorlage
                  34,
                  36,  # motcfx   Empfehlung des Bundesrates
                  54,  # partx - Teilnahme in Prozent
                  55,  # projetx - Zur Abstimmung vorgelegte Vorlage
                  56,  # themex - Thema der Vorlage
                  57,  # typex - Art der Vorlage
                  58,  # a01 - Teilnahme an Abstimmung
                  59,  # a04 - Abstimmungsmodus
                  60,
                  61,
                  62,
                  76,
                  77,
                  78,
                  80,
                  82,  # annee - Jahr der Abstimmung
                  88,
                  83,  # canton - Kanton
                  91,  # id - Identifizierungsnummer
                  93,  # jour - Tag der Abstimmung
                  117, # nombre - Anzahl der zur Abstimmung vorgelegten Vorlagen
                  120, # p02 - Parteiidentifizierung
                  121,
                  123,
                  127,
                  129, # regiling - Sprachregionen
                  130,
                  143, # scrutin - Nummer der standardisierten Umfrage
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
