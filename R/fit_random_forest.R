
fit_random_forest <- function(train_test_xy, n_tree = 100) {
  randomForest::randomForest(
    x = train_test_xy$train$x,
    y = train_test_xy$train$y,
    testx = train_test_xy$test$x,
    testy = train_test_xy$test$y,
    ntree = n_tree
  )
}
