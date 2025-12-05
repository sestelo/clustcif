library(testthat)
library(mstate)

data("ebmt2")

test_that(
  "Output is correct in kcif function",
  {
    expected <- c(1, 3, 3, 2, 2, 2, 3)
    fit <- out <- kcif(time = ebmt2$time, status = ebmt2$status, x = NULL,
                        k = 2, kbin = 50, algorithm = "kmeans", seed = 300716)
    expect_equal(fit$cluster, expected)
  }
)

