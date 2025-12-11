#' Summarizing fits of \code{clustcif} class produced by \code{clustcif}
#'
#' @description Takes a  clustcif object
#' and produces various useful summaries from it.
#'
#' @param object a clustccif object as producted by \code{clustcif}
#' @param \ldots additional arguments.
#'
#' @details \code{print.clustcif} tries to be smart about \code{summary.clustcif}.
#'
#' @return \code{summary.clustcif} computes and returns a list of summary
#' information for a \code{clustcurves} object.
#' \item{levels}{Levels of the factor.}
#' \item{cluster}{A vector containing the assignment of each factor's level to its group.}
#' \item{table}{A data.frame containing the results from the hypothesis test.}
#'@author Nora M. Villanueva and Marta Sestelo.
#'
#'@examples
#'\dontrun{
#' library(clustcif)
#' library(mstate)
#' data("ebmt2")
#'
#'# Testing the number of groups
#' outtest <- clustcif(time = ebmt2$time, status = ebmt2$status, x = NULL,
#'                         kvector = NULL,  kbin = 20, nboot = 100,
#'                         algorithm = "kmeans", cluster = TRUE)
#' summary(outtest)
#'}
#' @export



summary.clustcif <- function(object, ...){
  if (inherits(object, "clustcif")) {
  cat("\nCall: ","\n")
  print(object$call)
  cat("\nClustering curves in ", object$num_groups,
      " groups", "\n", sep = "")
  if(object$method == "cif"){
    cat("\nNumber of observations: ",length(object$data$time))
  }else{
    cat("\nNumber of observations: ",dim(object$data)[1])
  }
  cat("\nCluster method: ", object$algorithm, "\n")
  cat("\nFactor's levels:\n")
  print(object$levels, ...)
  cat("\nClustering factor's levels:\n")
  print((object$cluster - 1)[-1], ...)
  cat("\nTesting procedure:\n")
  print(object$table, ...)

  cat("\nAvailable components:", sep = "\n")
  print(names(object))
  invisible(object)
  }else{
    stop("Argument object must be a clustcif object.")
  }
}




