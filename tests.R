
qpc1 <- qpc(pauc = list(c(0,2), c(10, 20)))

qpc1
pauc(qpc1) <- list(c(0,2))
remove_pauc(qpc1) <- list(c(0,2))

library(PKPDdatasets)
library(dplyr)
sd_oral_richpk %>% s_quantiles("Conc", probs = c(0.1, 0.5))

qpc2 <- qpc(rdata = sd_oral_richpk, simdata = sd_oral_richpk %>% 
mutate(REP = ifelse(Gender =="Male", 1, 2)))

summarize_quantiles(qpc2,"Conc",rep_col_name = "REP", probs = c(0.75))
summarize_quantiles(qpc2,"Conc",rep_col_name = "REP", probs = c(0.5, 0.75))
summarize_quantiles(qpc2,"Conc",rep_col_name = "REP", probs = c(0.25, 0.5, 0.75))

str(qpc2$rdata)


grp <- function(df, gp) {
  df %>% group_by_(.dots = list(lazyeval::interp(gp, as.name(gp))))
}

qpc2$simdata %>% grp("REP")
