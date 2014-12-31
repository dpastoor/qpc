summarize_quantiles <- function(x, 
                        rdv, 
                        sdv, 
                        rep,
                        probs, 
                        na.rm=T) {
  UseMethod("summarize_quantiles", x)
}

#' get quantile summaries for real and simulated data for qpc object
#' @param x qpc object
#' @param rdv name of dv column for real data (eg "cobs")
#' @param sdv name of simulation data dv column if different than rdv
#' @param rep column name for replicates in simulated data
#' @examples
#' \dontrun{
#' summarize_quantiles(qpcdb, "CObs", "REP", probs = c(0.25, 0.5, 0.75))
#' }
summarize_quantiles.qpc <- function(x, 
                            rdv, 
                            sdv = dv, 
                            rep,
                            probs, 
                            na.rm=T) {
  if(is.null(x$rdata) | is.null(x$simdata)) {
    stop("qpc object must have both real and simulated data defined")
  }
  x[['rdata_quantiles']] <- PKPDmisc::s_quantiles(x$rdata, 
                                        dv, 
                                        probs, 
                                        na.rm)
  # s_quantiles behavior based on passing in a grouped/ungrouped df,
  # so want to group by REP before passing to s_quantiles to get quantile
  # by replicate
  gsimdat <- dplyr::group_by_(x$simdata, .dots = 
                                    list(lazyeval::interp(rep,
                                    rep = as.name(rep))))
  x[['simdata_quantiles']] <- PKPDmisc::s_quantiles(gsimdat, 
                                          sdv, 
                                          probs, 
                                          na.rm)
  return(x)
}