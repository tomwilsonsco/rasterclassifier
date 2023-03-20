test_that("default sample works", {
  test_balance_default <-  readRDS(test_path(
    "testdata",
    "test_balance_default.rds"
  ))

  set.seed(123)
  df <- data.frame(
    ml_class = c(
      rep(0, 20),
      rep(1, 10),
      rep(2, 5)
    ),
    b1 = stats::runif(35, 0, 1)
  )
  expect_equal(balance_classes(df, "ml_class", seed_val=123),
               test_balance_default)
})


test_that("specified sample size works", {
  test_balance_specified <-  readRDS(test_path(
    "testdata",
    "test_balance_specified.rds"
  ))

  set.seed(123)
  df <- data.frame(
    ml_class = c(
      rep(0, 20),
      rep(1, 10),
      rep(2, 5)
    ),
    b1 = stats::runif(35, 0, 1)
  )
  expect_equal(balance_classes(df,
                               "ml_class",
                               samples_per_class=4,
                               seed_val=123),
               test_balance_specified)
})

test_that("unchanged by sampling works", {
  test_balance_unchanged <-  readRDS(test_path(
    "testdata",
    "test_balance_unchanged.rds"
  ))

  set.seed(123)
  df <- data.frame(
    ml_class = c(
      rep(0, 4),
      rep(1, 4),
      rep(2, 4)
    ),
    b1 = stats::runif(12, 0, 1)
  )
  expect_equal(balance_classes(df,
                               "ml_class",
                               seed_val=123),
               test_balance_unchanged)
})
