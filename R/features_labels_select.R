.xy_col_selection <- function(training_df, class_column, y_as_factor) {
  x <- training_df %>% dplyr::select(-dplyr::all_of(c(class_column)))

  y <- training_df %>%
    dplyr::select(dplyr::all_of(c(class_column))) %>%
    dplyr::pull()

  if (y_as_factor) {
    y <- as.factor(y)
  }

  list(x = x, y = y)
}


#' Divide train and test dataframes to feature columns and label column.
#'
#' The list of train and test dataframes is split into sub lists of x and y.
#'
#' @param train_test_list List of dataframes.
#' @param class_column Name of the column indicating `y` label values - this
#' column is dropped from features.
#' @param y_as_factor Should the label variable be converted to a
#' factor datatype? Defaults to TRUE as required for many R ml classification
#' algorithms.
#'
#' @return A list of  a list of feature `X` and label `y` dataframes,
#' for both train and test.
#' @export
#'
#' @examples
#' iris %>%
#'   train_test_split() %>%
#'   features_labels_select(class_column = "Species")
features_labels_select <- function(train_test_list,
                      class_column = "ml_class",
                      y_as_factor = TRUE) {
  purrr::map(
    train_test_list,
    \(x) .xy_col_selection(x,
      class_column = class_column,
      y_as_factor = y_as_factor
    )
  )
}
