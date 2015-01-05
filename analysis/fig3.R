mmFplot <- data.frame(fixef(mmF), confint(mmF, method = 'Wald'))
names(mmFplot) <- c('coef', 'li', 'ui')  # name vars
rownames <- 1:length(mmFplot$coef)
mmFplot$names <- c('Intercept', 'Age', 'Gender', 'University Degree', 
                       'Romandie', 'Italian Switzerland', 
                       'Knows title or content', 'Knows title and content',
                       'Facultative Referendum', 'Counter-Proposal', 
                       'Initiative', 'Gov. Party Unity') # rename rows
mmFplot$names <- factor(mmFplot$names, levels=mmFplot$names, ordered = T)

intercept <- coef(mmF)$projetx[, 1]

dotplot(names ~ coef, data = mmFplot,
        panel = function(x, y) {
          panel.abline(v = 0, lty = 2)
          panel.xyplot(intercept, 1)
          panel.dotplot(x, y, col = 'black', lty = 5)
          panel.segments(mmFplot$li, as.numeric(y), mmFplot$ui,
                         as.numeric(y), lty = 1)
        })