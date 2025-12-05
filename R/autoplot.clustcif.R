#' @importFrom ggplot2 autoplot
#' @import ggfortify
#' @export
ggplot2::autoplot

#' Visualization of \code{clustcif} objects with ggplot2 graphics
#'
#' @description Useful for drawing the estimated functions grouped by
#' color and the centroids (mean curve of the functions pertaining to the
#' same group).
#'
#' @param object Object of \code{clustcif} class.
#' @param groups_by_colour A specification for the plotting groups by color.
#' @param centers  Draw the centroids (mean of the curves pertaining to the
#' same group) into the plot. By default it is \code{FALSE}.
#' @param conf.int Only for survival curves. Logical flag indicating whether to
#' plot confidence intervals. #conf.int = 0.95
#' @param xlab A title for the \code{x} axis.
#' @param ylab A title for the \code{y} axis.
#' @param interactive Logical flag indicating if an interactive plot with plotly is produced.
#' @param \ldots Other options. #ver si meter conf.type=c("log", "plain", "none"),
#'
#' @details See help page of the function \code{\link{autoplot.clustcif}}.
#'
#' @return A ggplot object, so you can use common features from
#' ggplot2 package to manipulate the plot.
#'
#' @author Nora M. Villanueva and Marta Sestelo.
#' @examples
#' library(clustcif)
#' library(mstate)
#' data("ebmt2")
#'
#'# Testing the number of groups
#' outtest <- clustcif(time = ebmt2$time, status = ebmt2$status, x = NULL,
#'                         kvector = NULL,  kbin = 50, nboot = 50,
#'                         algorithm = "kmeans", cluster = FALSE)
#' autoplot(outtest)
#' @importFrom RColorBrewer brewer.pal
#' @importFrom grDevices colorRampPalette
#' @export

autoplot.clustcif <- function(object = object, groups_by_colour = TRUE,
          centers = FALSE, conf.int = FALSE,
          xlab = "Time", ylab = "Cumulative Incidence Function",
          interactive = FALSE, ...){


  x <- object
  y <- c()
  k <- length(unique(x$cluster))

   if(k < 3){
     colgr <- RColorBrewer::brewer.pal(n = 3, name = "Dark2")
   }else if(k<9){
     colgr <- RColorBrewer::brewer.pal(n = k, name = "Dark2")
     }else{
  colgr <- colorRampPalette(brewer.pal(n = 8, name = "Dark2"))(k)
     }

  if(x$method == "cif"){ #interactive TRUE no funciona, ver si meterlo!

    if(isFALSE(centers)){

      #CORREGIR legend

      plot1 <- plot(x$curves, use.ggplot = TRUE, legend = x$levels[-1], ylim =c(0, max(x$curves[,-c(1:2)])))
      #plot1 <- plot(x$curves, use.ggplot = TRUE,  ylim =c(0, max(x$curves[,-c(1:2)])))


      if (isTRUE(groups_by_colour)){

        plot2 <- plot1 + ggplot2::scale_color_manual(values = colgr[x$cluster[-1]])
        if(isTRUE(interactive)){
          if (requireNamespace("plotly", quietly=TRUE)) {plotly::ggplotly(plot2)}
        }else{
          plot2
        }
      }else{
        if(isTRUE(interactive)){
          if (requireNamespace("plotly", quietly=TRUE)) {plotly::ggplotly(plot1)}
        }else{
          plot1
        }
      }



    }else{

     # FALTA
      # data <- data.frame(t = x$centers$time,
      #                    surv = x$centers$surv,
      #                    cen = factor(unlist(sapply(1:k, function(x, y){rep(x, y[x])},
      #                                               y = x$centers$strata))))
      #
      # plot1 <- autoplot(x$curves, conf.int = conf.int, censor = censor, xlab = xlab,
      #                   ylab = ylab, ...) + ggplot2::scale_color_manual(values = colgr[x$cluster])
      #
      #
      # plot2 <- plot1 + ggplot2::geom_step(data = data,
      #                                     ggplot2::aes_string(x = "t", y = "surv", group = "cen"), size = 1)
      #
      # if(isTRUE(interactive)){
      #   if (requireNamespace("plotly", quietly=TRUE)) {plotly::ggplotly(plot2)}
      # }else{
      #   plot2
      # }

    }

 }

}



