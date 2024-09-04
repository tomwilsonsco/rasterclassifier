# The mlc object stores means and a covariance matrix of pixel values
.mlc_inputs <- function(df, class_val) {
  return(list(class_val = class_val,
              mean_vec = colMeans(df),
              cov_mat = stats::cov(df)))
}

#' Fit a maximum likelihood classifier using input lists
#' of train, test x, y.
#'
#' Designed to receive input of `df |>
#' train_test_split() |>
#' features_labels_select()`
#'
#' A maximum likelihood classifier (mlc) is a traditional method used in remote
#' sensing. It assumes pixels in each band are normally distributed. The
#' mlc implemented in this package was written manually. Fitting an mlc stores
#' a vector of band means and a covariance matrix for each class. The
#' resulting mlc object can be passed to [predict()].
#'
#' @param train_test_xy List of train and test lists, each sub-list containing
#' an X dataframe and a y vector.
#'
#' @return A custom object of class mlc
#' @export
#'
#' @rdname fit_mlc
#' @examples
#' input_list <- iris |>
#'   train_test_split() |>
#'   features_labels_select(class_column = "Species") |>
#'   mlc()
mlc <- function(train_test_xy) {
  df <- train_test_xy$train$x
  y_train <- train_test_xy$train$y
  class_vals <- unique(train_test_xy$train$y)
  model <- lapply(class_vals, function(i) .mlc_inputs(df[y_train == i, ], i))
  names(model) <- paste0("class_val_", class_vals)
  class(model) <- "mlc"
  model
}
