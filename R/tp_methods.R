tp <- function(x){
  UseMethod("tp", x)
}

tp.qpc <- function(x) x[['tp']]

'tp<-' <- function(x, value) {
  UseMethod('tp<-', x)
}

'tp<-.qpc' <- function(x, value) {
  x[['tp']] <- value
  return(x)
}

'add_tp<-' <- function(x, value) {
  UseMethod('add_tp<-', x)
}

'add_tp.qpc' <- function(x, value) {
  x[['tp']] <- c(x[['tp']], value)
  return(x)
}

'remove_tp<-' <- function(x, value) {
  UseMethod('remove_tp<-', x)
}


'remove_tp<-.qpc' <- function(x, value) {
  tp <- tp[!tp %in% value]
  x[['tp']] <- tp
  return(x)
}
