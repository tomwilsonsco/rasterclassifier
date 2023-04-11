test_that("rf internal works", {
  test_list <- iris |>
    train_test_split(seed_value=123) |>
    features_labels_select(class_column="Species")

  saved_rf<- readRDS(test_path("testdata", "test_rf_trained.rds"))

  set.seed(123)
  rf <- fit_random_forest(test_list, ntree=100)

  expect_identical(rf$predicted, saved_rf$predicted)

})
