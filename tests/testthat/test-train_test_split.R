test_that("train test split works", {
  test_split <- readRDS(test_path(
    "testdata",
    "test_split.rds"
  ))

  expect_identical(
    train_test_split(iris, training_proportion = 0.8, seed_value = 123),
    test_split
  )
})
