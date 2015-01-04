pauc <- function(x){
  UseMethod("pauc", x)
}

pauc.qpc <- function(x) x[['pauc']]

'pauc<-' <- function(x, value) {
  UseMethod('pauc<-', x)
}

'pauc<-.qpc' <- function(x, value) {
  x[['pauc']] <- value
  return(x)
}

'add_pauc<-' <- function(x, value) {
  UseMethod('add_pauc<-', x)
}

'add_pauc.qpc' <- function(x, value) {
  if(!is.list(value)) {
    warning("For more than one pauc, must be a list, coercing to list.")
    value <- as.list(value)
  }
  if(is.null(x[['pauc']])) x[['pauc']] <- list()
  x[['pauc']] <- c(x[['pauc']], value)
  return(x)
}

'remove_pauc<-' <- function(x, value) {
  UseMethod('remove_pauc<-', x)
}


'remove_pauc<-.qpc' <- function(x, value) {
  if(!is.list(value)) {
    warning("For more than one pauc, must be a list, coercing to list.")
    value <- as.list(value)
  }
  
  pauc <- mapply(function(pauc, rm) {
    if(isTRUE(all.equal(pauc, rm))) pauc <- NULL
    pauc
  },x[['pauc']], value)
  
  x[['pauc']] <- Filter(Negate(is.null), pauc)
  return(x)
}
