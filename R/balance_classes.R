
# Smallest number of rows in df per class column value
count_smallest_class <- function(training_df, class_column) {
  min(table(training_df[[class_column]]))
}


#' Balance training data classes
#'
#' @param training_df Data frame to be balanced using class column.
#' @param class_column Name of the column to balance the classes.
#' @param sample_per_class Optional. Number of samples per class. Defaults to
#' NULL and if NULL the samples_per_class will be the size of the smallest
#' class. If specify a samples_per_class > the smallest class size then
#' sample_per_class size will revert to smallest class size -
#' sample with replacement is never used.
#'
#' @return A data.frame with a subset of rows of input df after sampling.
#' @export
#'
#' @examples
#' # Generate example df with unbalanced classes
#' df <- data.frame(
#'   ml_class = c(
#'     rep(0, 20),
#'     rep(1, 10),
#'     rep(2, 5)
#'   ),
#'   b1 = stats::runif(35, 0, 1)
#' )
#'
#' # Show initial unbalanced classes
#' table(df$ml_class)
#'
#' df <- balance_classes(df, "ml_class")
#'
#' # Show now balanced and as sample_per_class not specified each class has
#' # smallest initial class size number of samples (5)
#'
#' table(df$ml_class)
#'
balance_classes <- function(training_df,
                            class_column,
                            sample_per_class = NULL) {
  smallest_count <- count_smallest_class(training_df, class_column)

  if (is.null(sample_per_class)) {
    sample_per_class <- smallest_count
  } else if (sample_per_class > smallest_count) {
    sample_per_class <- smallest_count
  }

  training_df |>
    dplyr::group_by(.data[[class_column]]) |>
    dplyr::slice_sample(n = sample_per_class)
}
