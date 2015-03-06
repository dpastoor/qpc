#' qpc
#' 
#' @name qpc
#' @docType package
NULL

#' simulated 'real data' for use in qpc vignette
#' \itemize{
#'   \item ID Numerical ID  (1--50)
#'   \item TIME Time in hours (0--24)
#'   \item DV Plasma concentration in mg/L
#'   \item AMT Amount of drug given, time dependent, in milligrams
#'   \item DOSE Dose given to each individual in milligrams
#'   \item MDV Missing dependent variable
#'   \item ISM is male 
#' }
#' @docType data
#' @keywords datasets
#' @name obs_data1
#' @usage data(obs_data1)
NULL

#' simulated data from 'real data' fit for obs_data1
#' \itemize{
#'   \item ID Numerical ID  (1--50)
#'   \item REP replicate
#'   \item TIME Time in hours (0--24)
#'   \item DV Plasma concentration in mg/L
#'   \item IPRED individual predicted value
#'   \item PRED population predicted value
#'   \item AMT Amount of drug given, time dependent, in milligrams
#'   \item DOSE Dose given to each individual in milligrams
#'   \item ISM is male 
#'   \item MDV Missing dependent variable
#' }
#' @docType data
#' @keywords datasets
#' @name sim_data1
#' @usage data(sim_data1)
NULL