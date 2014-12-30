qpc <- function(rdata = NULL, 
                simdata = NULL, 
                pauc = NULL, 
                tp = NULL,
                tests = c("ppeq, pp")) {
  out <- list(rdata = rdata, 
              simdata = simdata,
              pauc = pauc,
              tp = tp,
              tests = tests)
  class(out)<- "qpc"
  out
}

rdata <- function(x){
  UseMethod("rdata", x)
}

rdata.qpc <- function(x) x[['rdata']]

'rdata<-' <- function(x, value) {
  UseMethod('rdata<-', x)
}

'rdata<-.qpc' <- function(x, value) {
  x[['rdata']] <- value
  return(x)
}

simdata <- function(x){
  UseMethod("simdata", x)
}

simdata.qpc <- function(x) x[['simdata']]

'simdata<-' <- function(x, value) {
  UseMethod('simdata<-', x)
}

'simdata<-.qpc' <- function(x, value) {
  x[['simdata']] <- value
  return(x)
}


tests <- function(x) {
  UseMethod("tests", x)
}

tests.qpc <- function(x) x[['tests']]

