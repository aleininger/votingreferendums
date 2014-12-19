Standardisierung
================

## Die Kategorien der standardisierten Variablen (VS)

Die standardisierten Dateien beinhalten drei Typen von Variablen:

- standardisierte Quellenvariablen (VSS);
- externe standardisierte Variablen (VSE);
- neu kodierte standardisierte Variablen (VSR).

Die VSS, die ungefähr 2/3 aller VS darstellen, sind diejenigen Variablen, die die aus den originalen Vox-Umfragen stammenden Daten integrieren. Diese Integration findet beim Import der originalen Variablen (VO) in die VoxIt Datenbank statt und durch die Rekodierung in die vorbestimmten Codes der VSS, die ihnen entsprechen. Wir möchten Sie darauf aufmerksam machen, dass jedoch nicht alle VO standardisiert werden. Die Kriterien für eine Standardisierung der Varaiblen finden Sie unter der Rubrik "Prinzipien und Wahl der Standardisierung". Die VO, die für jede Variable und jeden "Abstimmungstermin" verwendet worden ist, finden Sie auf dem Dokument, dass die Zusammenhänge VO-VSS erläutert.

Die VSE sind Variablen, die kontextuelle Informationen in Verbindung mit den "Abstimmungsterminen" und "Vorlagen" beinhalten, d.h. mit der Wahlbeteiligung, den detaillierten Resultaten, den Abstimmungsparolen, usw. Sie machen den grössten Teil der Gruppe "I. Meinungsumfragen, Abstimmungen und Vorlagen" aus. Die meisten Daten in den VSE stammen aus der offiziellen Website der Bundeskanzlei, die den Abstimmungsresultaten gewidmet ist. Die Informationen zu den Abstimmungsparolen der politischen Parteien werden von einer Datenbank geliefert, die von Institut für Politikwissenschaft der Universität Bern verwaltet wird. Professor Hanspeter Kriesi (Institut für Politikwissenschaft der Universität Zürich) ist verantwortlich für die Definition der Variable "themex" und für die Klassifizierung der "Vorlagen" in dieser Zusammenstellung.

Die VSR sind Variablen, die aufgrund von Informationen in den VSS und/oder den VSE konstruiert wurden mit dem Ziel, eine synthetische Information über möglichst viele Umfragen zu geben. Diese Kategorie beinhaltet im Moment noch eine relativ kleine Anzahl Variablen. Es gibt zwei Sorten dieser von den VSR gemachten Synthese. Sie ist synchron, wenn sie in einer einzigen Variable Informationen integriert, die auf verschiedene VSS innerhalb eines "Abstimmungstermins" oder einer "Vorlage" verteilt sind; diachron, wenn sie mehrere VSS vereinigt, die sich im Laufe der Umfragen abgelöst haben, da sich die Art und Weise, wie ein gleicher Typ von Informationen gesammelt worden ist, zu sehr verändert hat, um diese in einer einzelnen VSS zu integrieren (Liste und Zusatzinformationen).

Eine Liste von allen VS, nach ihrem Namen alphabetisch geordnet, ermöglicht herauszufinden, zu welchem Typ eine Variable gehört. Diese Liste gibt auch die vollständige Bezeichnung von jeder VS und deren Gruppe. Um den Durchblick zu erleichtern, kommen die Variablen "Vorlage" nur einmal unter ihrem generischen Namen vor, was auch der Struktur der Datei "Vorlagen" entspricht. Man sollte sich also daran erinnern, dass z.B. "blancsx" 6 Variablen in den Dateien vom Typ "Abstimmungstermin" darstellt, nämlich die Variablen "blancsx1" bis "blancsx6" (siehe die Liste der standardisierten Variablen). 


## Organisation des Dokuments, das die Zusammenhänge VO-VSS beschreibt

Generell haltet sich die Organisation dieses Dokuments an die Struktur der Datei "Abstimmungstermine" und an die Gruppierung der Variablen, wie sie in VoxIt angewendet wird (siehe Gruppen; oder standardisierte Variablen für die Gruppenzugehörigkeit).

Jeder Gruppe von VSS ist eine eigene Seite mit einer alphabetisch klassierten Tabelle der Variablen gewidmet. Der Name der VSS ist in der Reihe "A" angegeben, die Bezeichnung in der Reihe "B". Die Nummer der zur Verfügung stehenden "Abstimmungstermine" findet man in der Linie "1". Die VSS sind demnach in Linien dargestellt und die "Abstimmungstermine" in Reihen. Jede Zelle gibt an, ob ein Zusammenhang mit einem gegebenen "Abstimmungstermin" existiert und gibt, wenn das der Fall ist, den Namen der integrierten originalen Variable an. Wenn kein Zusammenhang besteht, werden drei verschiedene Codes unterschieden:

-"O" zeigt eine momentane Abwesenheit an (z.B. wenn sich die Variable nicht auf den betrachteten "Abstimmungstermin"/"Vorlage" anwendet)
- "K" zeigt an, dass die originale Variable noch nicht in der betrachteten Umfrage existiert
- "M" zeigt an, dass die originale Variable nicht mehr existiert .

Unerklärbare Abwesenheiten, Fehler und andere Besonderheiten wurden mit verschiedenen Farbe gekennzeichnet. Gelegentlich finden Sie auch einen Kommentar, der zusätzliche Informationen liefert. Beim Lesen dieser Beschreibung sollten für Sie für die Dateitypen "Abstimmungstermin" keine Schwierigkeiten haben.

zur detaillierten Beschreibung der Zusammenhänge VO-VSS (Bemerkung: dieses Dokument wurde mit Microsoft Excel 2003 erstellt und ist lesbar für frühere Versionen ab Excel 5.0/95 und für Excel X for Mac 2001)

### Die Beschreibung im Rahmen des Dateityps "projet"

Das Lesen der Beschreibung für Dateien vom Typ "Vorlage" ist weniger einfach, insbesondere für vorlagespezifische Variablen, d.h. solche deren Name in diesem Dateityp mit einem "x" endet (siehe Details zum Namen der standardisierten Variablen).

Man muss auf jeden Fall unbedingt die Nummer der "Vorlage", zu welcher man Informationen sucht, kennen. Für einzelne Dateien vom Typ "projxxy" ist diese Nummer im Dateinamen beinhaltet. Für die kumulierte Datei "Vorlagen" beinhaltet die Variable "projetx" diese Information. Diese Nummer wird folgendermassen interpretiert: die ersten zwei Zahlen bezeichnen die Nummer des "Abstimmungstermin" aus welchem die"Vorlage" stammt und die letzte Zahl bezeichnet die Position innerhalb der Reihe von "Vorlagen" eines "Abstimmungstermins". Für alle nicht vorlagespezifischen Variablen genügt es demnach, die Reihe "Abstimmungstermin" anzusehen. Wenn es sich um Variablen auf der Ebene "Vorlage" handelt (deren Name mit einem "x" endet), muss man zusätzlich die Variable, die die gleiche Zahl wie die Nummer des betrachteten "Vorlage" trägt, wählen (siehe Suchbeispiele)

zur detaillierten Beschreibung der Zusammenhänge VO-VSS (Bemerkung: dieses Dokument wurde mit Microsoft Excel 2003 erstellt und ist lesbar für frühere Versionen ab Excel 5.0/95 und für Excel X for Mac 2001)


## Die rekodierten standardisierten Variablen

Eine Beschreibung mit der Konstruktionssyntax (SPSS) für alle diese Variablen steht in der Dokumentation der standardisierten Variablen zur Verfügung.

VSR: synchrone Synthese

- Die VSR "decx", genannt "Abstimmungsentscheid zur Vorlage", beinhaltet für die "Vorlagen" bis zum "Abstimmungstermin" 69, die Informationen der Variable "a02x : Stimmverhalten der Teilnehmenden" und die der Variable "a03x : Stimmverhalten der Nicht-Teilnehmenden"; ab dem "Abstimmungstermin" 69 ist die Variable "a03x" nicht mehr vorhanden und die Daten der "decx" sind identisch mit jenen der "a02x".

die Beschreibung der Variable "decx1"

- Die VSR "conx", genannt "Kenntnisskala (0-2) für die Vorlage" summiert die politischen Kenntnisse und basiert sich auf die Variablen "a31x : Kenntnis des Vorlagentitels" und "a32x : Kenntnis der Vorlage in den Einzelheiten".

die Beschreibung der Variable "conx1"

 

VSR: diachrone Synthese

Bemerkung: eine diachrone Synthese kann einen Schärfeverlust der Information bedeuten, da eine solche Konstruktion manchmal mit sich bringt, dass die am meisten detaillierten VSS auf die am wenigsten detaillierten VSS reduziert werden. Diese Synthese bietet jedoch die einzige Möglichkeit, Vergleiche zwischen weit entfernten "scrutin" zu machen, die für einige Daten keine gemeinsamen VSS besitzen.

- Die VSR "impactx", bezeichnet als "Schätzung der Auswirkung der Vorlage" vereinigt die VSS "a82x : Erwartete Auswirkung (für die Vorlage)", welche die "Abstimmungstermine" 15 bis 48 abdeckt und die VSS "a89x : Bedeutung der Vorlage für mich persönlich", die ihr in gewisser Weise nachfolgt.

Beemerkung: Es ist normal, dass "impactx" keinen Wert "0" für die "Abstimmungstermine" 15 bis 48 haben kann, da die Variable "a82x" mit dem Wert "1. Très faible" beginnt.

die Beschreibung der Variable "impactx1"

- Die VSR "age", genannt "Alter in Jahren", integriert die aufeinanderfolgenden Versionen der Variable "s12", die Informationen zum Alter der Befragten beinhaltet. In den Umfragen vor Vox 29 wurde diese Information als Kategorien erfasst, in den nachfolgenden Umfragen jedoch als Anzahl Lebensjahre. In dieser VSR wurden die Kategorien der ersten Version der "s12" für jede Person mit dem Durchschnitt, in Jahren, der Grenzwerte jeder Kategorie ersetzt.

die Beschreibung der Variable "age"

- Die VSR "inteloca", genannt "Lokale Integration", bietet synthetische Information zur zeitlichen Dimension des aktuellen Wohnsitzes der Befragten. In dieser VSR wurde die zweite Version der VSS "s19v2", die 3 Kategorien enthielt, auf die nur 2 Kategorien enthaltenden "s19v1" reduziert.

die Beschreibung der Variable "inteloca"

- die VSR "voiture", genannt "Besitzt Auto", integriert die aufeinanderfolgenden Versionen der Variable "s38" indem sie die VSS "s38v2", welche die genaue Anzahl Automobile erfasst, auf die VSS "s38v1" reduziert, deren Information dichotom ist (ja/nein).

die Beschreibung der Variable "voiture" 