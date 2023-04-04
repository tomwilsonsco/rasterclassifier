split_and_fit <- function(training_df,
                           classifier,
                           class_column,
                           n_tree) {
  tt_xy <- training_df %>%
    train_test_split() %>%
    xy_select(class_column)

  if (classifier=="random_forest"){
    model <- fit_random_forest(tt_xy)
    pred_y <- stats::predict(model, tt_xy$test$x)
  }

  # Add other classifiers here in time....

  get_ml_metrics(pred_y, tt_xy$test$y)
}



classif_train_test <- function(training_df,
                          n_tests = 5,
                          classifier = "random_forest",
                          class_column = "ml_class",
                          n_tree = 100) {

  metrics <- purrr::map(1:n_tests, \(x) split_and_fit(training_df = training_df,
                                         classifier = classifier,
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
