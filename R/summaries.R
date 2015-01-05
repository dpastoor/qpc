#' @export
calculate_paucs <- function(x,
                            rdv_time,
                            rdv,
                            sdv_time,
                            sdv,
                            id,
                            rep) {
  UseMethod("calculate_paucs", x)
}

#' calculate partial aucs for those defined in pauc
#' @export
calculate_paucs.qpc <- function(x,
                                rdv_time, 
                                rdv,
                                sdv_time = rdv_time,
                                sdv = rdv,
                                id,
                                rep) {
  if(is.null(x$rdata) | is.null(x$simdata)) {
    stop("qpc object must have both real and simulated data defined")
  }
  if(is.null(x$pauc)) {
    stop("please define at least one pauc to calculate")
  }
  grdat <- dplyr::group_by_(x$rdata, .dots = 
                                list(lazyeval::interp(id,
                                                      id = as.name(id))))
  x[['rdata_pauc']] <- PKPDmisc::s_pauc(grdat, rdv_time, rdv, x$pauc)
  gsimdat <- dplyr::group_by_(x$simdata, .dots = 
                                list(lazyeval::interp(id,
                                                      id = as.name(id)),
                                     lazyeval::interp(rep,
                                                      rep = as.name(rep))
                              ))
  x[['simdata_pauc']] <- PKPDmisc::s_pauc(gsimdat, sdv_time, sdv, x$pauc)
    return(x)
}

#' @export
calculate_quantiles <- function(x, 
                        probs, 
                        rep="REP",
                        na.rm=T) {
  UseMethod("calculate_quantiles", x)
}

#' get quantile summaries for real and simulated data for qpc object
#' @param x qpc object
#' @param probs probabilities for which quantiles to calculate (eg 0.75 for 75th percentile)
#' @param rep column name for replicates in simulated data
#' @export
#' @examples
#' \dontrun{
#' calculate_quantiles(qpcdb, probs = c(0.25, 0.5, 0.75))
#' }
calculate_quantiles.qpc <- function(x, 
                            probs, 
                            rep = "REP",
                            na.rm=T) {
  if(is.null(x$rdata) | is.null(x$simdata)) {
    stop("qpc object must have both real and simulated data defined")
  }
  if(is.null(x$pauc)) {
    stop("please define at least one pauc or tp to calculate quantiles")
  }
  
  if(!is.null(x$pauc)) {
    pauc_cols <- names(x$rdata_pauc)[grep('pAUC', names(x$rdata_pauc))]
    x[['r_pauc_quantiles']] <- list()
    for(i in seq_along(pauc_cols)) {
      pauc_name <- pauc_cols[i]
      # ungroup to make sure no grouping vars passed in
      x[['r_pauc_quantiles']][[pauc_name]] <- PKPDmisc::s_quantiles(dplyr::ungroup(x$rdata_pauc), 
                                                                  pauc_name, 
                                                                  probs, 
                                                                  na.rm)
      #group by REP only
      # s_quantiles behavior based on passing in a grouped/ungrouped df,
      # so want to group by REP before passing to s_quantiles to get quantile
      # by replicate
      
      gsimdat_pauc <- dplyr::group_by_(x$simdata_pauc, .dots = 
                                    list(lazyeval::interp(rep,
                                                          rep = as.name(rep))))
      x[['s_pauc_quantiles']][[pauc_name]] <- PKPDmisc::s_quantiles(gsimdat_pauc, 
                                                                    pauc_name, 
                                                                    probs, 
                                                                    na.rm)
    }

  }
  if(!is.null(x$tp)) {
     #TODO: add single time points
  }

  return(x)
}