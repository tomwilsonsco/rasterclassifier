xy_select <- function(training_df, class_column) {
  x <- training_df %>% dplyr::select(- dplyr::all_of(c(class_column)))

  y <- training_df %>% dplyr::select(dplyr::all_of(c(class_column)))

  list(x = x, y = y)
}


#' Divide train and test dataframes to x and y columns.
#'
#' The list of train and test dataframes is split into sub lists of x and y.
#'
#' @param train_test_list List of dataframes.
#' @param class_column Name of the column indicating y values - this column is
#' dropped from x and is the only output of y.
#'
#' @return A list of  a list of x and y dataframes, for both train and test.
#' @export
#'
#' @examples
xy_selection <- function(train_test_list, class_column){
  purrr::map(train_test_list, xy_split, class_column=class_column)
}
