xy_select <- function(training_df, class_column, y_as_factor) {
  x <- training_df %>% dplyr::select(-dplyr::all_of(c(class_column)))

  y <- training_df %>%
    dplyr::select(dplyr::all_of(c(class_column))) %>%
    dplyr::pull()

  if (y_as_factor) {
    y <- as.factor(y)
  }

  list(x = x, y = y)
}


#' Divide train and test dataframes to x columns and y column.
#'
#' The list of train and test dataframes is split into sub lists of x and y.
#'
#' @param train_test_list List of dataframes.
#' @param class_column Name of the column indicating y values - this column is
#' dropped from x and is the only output of y.
#' @param y_as_factor Should the y variable by converted to a factor datatype.
#' Defaults to TRUE as required for many R ml classification algorithms.
#'
#' @return A list of  a list of x and y dataframes, for both train and test.
#' @export
#'
#' @examples
xy_select <- function(train_test_list, class_column, y_as_factor = TRUE) {
  purrr::map(train_test_list,
    xy_select,
    class_column = class_column,
    y_as_factor = y_as_factor
  )
}
