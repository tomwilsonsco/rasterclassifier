test_that("n tests works", {
  test_res <- classif_train_test(iris,
                     n_tests=4,
                     class_column="Species",
                     silent=TRUE)

  expect_equal(length(test_res), 4)

  expect_equal(names(test_res[[1]]), c("confusion_matrix",
                                     "precision",
                                     "recall",
                                     "f1_score",
                                     "overall"))
})
