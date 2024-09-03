
# calculate the multivariate normal density
.mvn_density <- function(x, mlc_input) {
  mean_vec <- mlc_input$mean_vec
  cov_mat <- mlc_input$cov_mat
  x <- as.numeric(x)

  # determinant of the covariance matrix
  det_sigma <- det(cov_mat)

  # inverse of the covariance matrix
  inv_sigma <- solve(cov_mat)

  # Mahalanobis distance squared
  mahal_dist_sq <- (x - mean_vec) %*% inv_sigma %*% (x - mean_vec)

  # density
  density <- exp(-0.5 * mahal_dist_sq) /
    (sqrt(2 * pi)^ncol(cov_mat) * sqrt(det_sigma))

  return(density[[1]])
}

.ml_density <- function(x, mlc){
  # calculate the multivariate normal density for each class and normalise
  predictions <- lapply(mlc, .mvn_density, x=x)
  predictions <- lapply(predictions, function(x){x/sum(unlist(predictions))})
  predictions
}

.predict_class <- function(x, mlc){
  # get the class prediction by selecting the largest density
  predictions <- .ml_density(x, mlc)
  prediction_class_key <- names(predictions)[which.max(unlist(predictions))]
  as.numeric(substring(prediction_class_key,11))
}

predict_mlc <- function(mlc, x){
  class_predict <- lapply(1:nrow(x),
                          function(i) .predict_class(x[i,], mlc))
  unlist(class_predict)
}
