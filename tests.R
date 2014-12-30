
qpc1 <- qpc(pauc = list(c(0,2), c(10, 20)))

qpc1
pauc(qpc1) <- list(c(0,2))
remove_pauc(qpc1) <- list(c(0,2))
