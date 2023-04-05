.split_and_fit <- function(training_df,
                           classifier,
                           class_column,
                           training_proportion,
                           ...) {
  tt_xy <- training_df %>%
    train_test_split(training_proportion = training_proportion) %>%
    xy_select(class_column)

  if (classifier == "random_forest") {
    model <- fit_random_forest(tt_xy, ...)
    pred_y <- stats::predict(model, tt_xy$test$x)
  }

  # Add other classifiers here in time....

  get_ml_metrics(pred_y, tt_xy$test$y)
}

.print_metrics <- function(metrics) {
  message("Confusion matrices for n_tests:")
  purrr::imap(metrics, \(x, y){
    cat("\n")
    cat("Test", y)
    print(x$confusion_matrix)
  })

  cat("\n")

  message("Precision, recall, F1, overall per test")
  metrics_df <- purrr::map_df(metrics, \(x) x[c(
    "precision",
    "recall", "f1_score", "overall"
  )])
  print(metrics_df)

  cat("\n")

  message("Mean precision, recall, F1, overall")
  print(colMeans(metrics_df))
}


#' Classifier testing n times against different train test splits.
#'
#' This process will print metrics specified by [get_lassif_metrics()] and
#' print a mean per metric over all tests.
#'
#' @param training_df Input dataframe to be used for training and testing
#' classifier.
#' @param n_tests How many different train-test splits and tests to run.
#' @param classifier Machine learning classifier to use. Currently the default
#' and only option is random_forest.
#' @param class_column Name of the column in training_df containing class
#' labels.
#' @param training_proportion Proportion of `training_df` rows used for
#' training compared to testing. Defaults to 0.75.
#' @param silent Whether to print metrics for each test. Defaults to TRUE.
#' @param ... Other arguments to be passed to classifier algorithm. For example
#' if random_forest can specify ntree for the number of decision trees used.
#'
#' @return List of metrics as determined by [get_classif_metrics()]
#' @export
#'
#' @examples
#' iris |> classif_train_test(class_column = "Species")
classif_train_test <- function(training_df,
                               n_tests = 5,
                               classifier = "random_forest",
                               class_column = "ml_class",
                               training_proportion = 0.75,
                               silent = FALSE,
                               ...) {
  metrics <- purrr::map(1:n_tests, \(x) .split_and_fit(
    training_df = training_df,
    classifier = classifier,
    class_column = class_column,
    training_proportion,
    ...
  ))

  if (!silent) {
    .print_metrics(metrics)
  }

  invisible(metrics)
}
