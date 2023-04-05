
#' Fit a [randomForest::randomForest()] using input lists
#' of train, test x, y.
#'
#' Designed to receive input of `df |> train_test_split() |>% xy_select()`
#'
#' @param train_test_xy List of train and test lists, each sub-list containing
#' an X dataframe and a y vector.
#' @param ... Arguments other than x, y, testx, testy to be passed to
#' randomForest::randomForest(). For example might want to change ntree from
#' its default of 500.
#'
#' @return An object of class randomForest (see [randomForest::randomForest()])
#' @export
#'
#' @examples
#' input_list <- iris %>%
#'   train_test_split() %>%
#'   xy_select(class_column = "Species")
#' fit_random_forest(input_list, ntree = 100)
fit_random_forest <- function(train_test_xy, ...) {
  randomForest::randomForest(
    x = train_test_xy$train$x,
    y = train_test_xy$train$y,
    testx = train_test_xy$test$x,
    testy = train_test_xy$test$y,
    ...
  )
}
