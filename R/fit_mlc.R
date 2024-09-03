.mlc_inputs <- function(df, class_val) {
  return(list(class_val = class_val,
              mean_vec = colMeans(df),
              cov_mat = cov(df)))
}

fit_mlc <- function(train_test_xy) {
  df <- train_test_xy$train$x
  y_train <- train_test_xy$train$y
  class_vals <- unique(train_test_xy$train$y)
  mlc <- lapply(class_vals, function(i) .mlc_inputs(df[y_train == i, ], i))
  names(mlc) <- paste0("class_val_", class_vals)
  mlc
}
