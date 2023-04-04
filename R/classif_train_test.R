run_train_test <- function(training_df,
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

  get_ml_metrics(rf$predicted, rf$y)
}



rf_train_test <- function(training_df,
                          n_tests = 5,
                          class_column = "ml_class",
                          n_tree = 100) {

  metrics <- purrr::map(1:5, \(x) run_train_test(training_df = training_df,
                                         class_column = class_column,
                                         n_tree = n_tree))


  metrics_df <- purrr::map_df(metrics, \(x) x[c("precision",
                                                "recall", "f1_score")])

  message("Precision, recall, F1 table")
  print(metrics_df)

  message("Mean precision, recall F1")
  print(colMeans(metrics_df))

  invisible(metrics)
}
