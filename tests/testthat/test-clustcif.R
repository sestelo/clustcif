library(testthat)
library(mstate)

data("ebmt2")

test_that( "CIF fit computed correctly", {
    expected <- c(1, 5, 2, 4, 4, 4, 3)
    fit <- clustcif(time = ebmt2$time, status = ebmt2$status, x = NULL,
                kbin = 50, algorithm = "kmeans", seed=300716, cluster=F,
                nboot=2)
    expect_equal(fit$cluster, expected)
    expect_s3_class(fit, "clustcif")
    expect_match(mode(fit), "list")
  }
)
