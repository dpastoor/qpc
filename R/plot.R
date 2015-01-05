#' @export
plot <- function(x) {
  UseMethod("plot",x)
}

#' plot 
#' @export
plot.qpc <- function(x) {
  rdata_quantiles <- x$r_pauc_quantiles
  sdata_quantiles <- x$s_pauc_quantiles
  
  library(ggplot2)
  for(i in seq_along(rdata_quantiles)) {
    rq1 <- rdata_quantiles[i]
    sq1 <- sdata_quantiles[i]
    rvalue <- data.frame(key = names(rq1[[1]]), rvalue = rq1[[1]])
    
    summary <- dplyr::inner_join(gather(sq1[[1]], key, value, -REP), rvalue)
    p <- summary %>% ggplot(aes(x = value, group = key)) +geom_histogram(color = "black", fill="white") +
      facet_wrap(~key, scales="free") + PKPDmisc::base_theme_obs() + geom_vline(aes(xintercept = rvalue), color = "red", size = 2) +
      xlab(names(rq1))
    print(p)
    return(p)
  }
  
}



