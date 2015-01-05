
qpc1 <- qpc(pauc = list(c(0,2), c(10, 20)))

qpc1
pauc(qpc1) <- list(c(0,2))
remove_pauc(qpc1) <- list(c(0,2))

library(PKPDdatasets)
library(dplyr)
sd_oral_richpk %>% s_quantiles("Conc", probs = c(0.1, 0.5))

qpc2 <- qpc(rdata = sd_oral_richpk, simdata = sd_oral_richpk %>% 
mutate(REP = ifelse(Gender =="Male", 1, 2)))

pauc(qpc2) <- list(c(0, 8), c(0, 24))

qpc2 <- calculate_paucs(qpc2, "Time", "Conc", id = "ID", rep = "REP")

head(qpc2$rdata_pauc)
head(qpc2$simdata_pauc)

qpc3 <- calculate_quantiles(qpc2, probs = c(0.25, 0.5, 0.75))
qpc3$r_pauc_quantiles
qpc3$s_pauc_quantiles

#still need to test/properly check for pauc being added but the pauc not calculated
# before a quantile is requested
# determine when to dispatch the calculate_pauc function
grp <- function(df, gp) {
  df %>% group_by_(.dots = list(lazyeval::interp(gp, as.name(gp))))
}

qpc2$simdata %>% grp("REP")


qpc <- qpc(rdata = read.csv("~/Downloads/data1.csv"), 
           simdata = dplyr::as_data_frame(data.table::fread("~/Downloads/qpcsim.csv")))

pauc(qpc) <- list(c(0,2), c(2, 12))

pauc(qpc)

names(qpc$simdata)

names(qpc$rdata)

qpc <- calculate_paucs(qpc,"TIME", "DV", id = "ID", rep = "REP")

qpc <- calculate_quantiles(qpc, probs = c(0.25, 0.5, 0.75))

plot(qpc)
