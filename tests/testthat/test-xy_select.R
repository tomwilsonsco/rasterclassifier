test_that("xy selection works", {
  test_split <- readRDS(test_path(
    "testdata",
    "test_split.rds"
  ))

  test_split_xy <- readRDS(test_path(
    "testdata",
    "test_split_xy.rds"
  ))

  expect_identical(xy_select(test_split, "Species"), test_split_xy)
})
