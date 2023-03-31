get_metrics <- function(rf) {
  metrics <- list(
    accuracy = MLmetrics::Accuracy,
    precision = MLmetrics::Precision,
    recall = MLmetrics::Recall
  )
  purrr::map_df(metrics, function(f) {
    f(rf$predicted, rf$y)
  })
}


run_train_test <- function(.x,
                           training_df,
                           class_column,
                           n_tree) {
  tt_xy <- training_df %>%
    train_test_split() %>%
    xy_select(class_column)

  rf <- randomForest::randomForest(
    x = tt_xy$train$x,
    y = tt_xy$train$y,
    testx = tt_xy$test$x,
    testy = tt_xy$test$y,
    ntree = n_tree
  )

  get_metrics(rf)
}



rf_train_test <- function(training_df,
                          n_tests = 5,
                          class_column = "ml_class",
                          n_tree = 100) {
  purrr::map_df(1:n_tests,
  run_train_test,
  training_df = training_df,
  class_column = class_column,
  n_tree = n_tree)
}
