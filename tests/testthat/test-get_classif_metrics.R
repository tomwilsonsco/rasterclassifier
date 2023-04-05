test_that("binary metrics work", {
  # Set up test data
  set.seed(123)
  actual_y <- sample(c(0, 1), 1000, replace = TRUE)
  pred_y <- actual_y
  pred_y[1:100] <- 0
  pred_y[101:200] <- 1

  metrics <- get_classif_metrics(pred_y, actual_y)

  expect_equal(metrics$confusion_matrix[2, 2], 451)

  expect_equal(metrics$overall, 0.911)

  expect_equal(metrics$precision, 0.90744, tolerance = 5)

  expect_equal(metrics$recall, 0.91300, tolerance = 5)

  expect_equal(metrics$f1_score, 0.91019, tolerance = 5)
})


test_that("multiclass metrics work", {
  # Set up test data
  set.seed(123)
  actual_y <- sample(c(0, 1, 2), 1000, replace = TRUE)
  pred_y <- actual_y
  pred_y[1:100] <- 0
  pred_y[101:200] <- 1
  pred_y[201:300] <- 2

  metrics <- get_classif_metrics(pred_y, actual_y)

  expect_equal(metrics$confusion_matrix[3, 3], 276)

  expect_equal(metrics$overall, 0.794)

  expect_equal(metrics$precision, 0.79512, tolerance = 5)

  expect_equal(metrics$recall, 0.79510, tolerance = 5)

  expect_equal(metrics$f1_score, 0.79511, tolerance = 5)
})

test_that("one class gives error", {
  expect_error(get_classif_metrics(c(0,0,0,0,0,0), c(0,0,0,0,0,0)),
               "There is only one class: 0")

})


