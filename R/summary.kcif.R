#' Summarizing fits of \code{kcif} class produced by \code{kcif}
#'
#' @description Takes a  kcif object
#' and produces various useful summaries from it.
#'
#' @param object a kcif object as produced by \code{kcif}.
#' @param \ldots additional arguments.
#'
#' @details \code{print.kcif} tries to be smart about \code{summary.kcif}.
#'
#' @return \code{summary.kcif} computes and returns a list of summary
#' information for a \code{kcif} object.
#' \item{levels}{Levels of the factor.}
#' \item{cluster}{A vector containing the assignment of each factor's level to its group.}
#'
#'@author Nora M. Villanueva and Marta Sestelo.
#'
#'@examples
#' library(mstate) # data from this package
#' library(clustcif)
#' data("ebmt2")
#' out <- table(ebmt2$cod) # causes of death
#' table9 <- c(out[-1], out[1]) # reorder causes of death
#' names(table9)[7] <- "Censored" # changed name of the last cause of death
#' (table9 <- data.frame(t(table9)))
#' #Estimating the CIFs given a number of k = 2 groups
#' out <- kcif(time = ebmt2$time, status = ebmt2$status, x = NULL,
#'                  k = 2, kbin = 50, algorithm = "kmeans")
#'
#' summary(out)
#'
#'
#'
#' @export



summary.kcurves <- function(object, ...){
  cat("\nCall: ","\n")
  print(object$call)
  cat("\nClustering curves in ", length(unique(object$cluster)),
      " groups", "\n", sep = "")
  if(object$method == "survival"){
    cat("\nNumber of observations: ",length(object$centers$time)) #cambiar a lenght(object$curves$time)
  }else{
    cat("\nNumber of observations: ",dim(object$data)[1])
  }
  cat("\nCluster method: ", object$algorithm, "\n")
  cat("\nFactor's levels:\n")
  print(object$levels, ...)
  cat("\nClustering factor's levels:\n")
  print(object$cluster, ...)


  cat("\nAvailable components:", sep = "\n")
  print(names(object))
  invisible(object)
}




