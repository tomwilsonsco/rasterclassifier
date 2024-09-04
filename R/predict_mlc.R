
# calculate the multivariate normal density
.mvn_density <- function(object, x) {
  mean_vec <- mlc$mean_vec
  cov_mat <- mlc$cov_mat
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

# mlc for each class
.likelihood_mlc <- function(object, x){
  # calculate the multivariate normal density for each class and normalise
  predictions <- purrr::map_dbl(object, .mvn_density, x=x)
  predictions <- purrr::map_dbl(predictions, \(x) x/sum(predictions))
  predictions
}

.class_mlc <- function(object, x){
  # get the class prediction by selecting the largest density
  if (all(is.na(x))){
    return(NA)
  }
  predictions <- .likelihood_mlc(object, x)
  prediction_class_key <- names(predictions)[which.max(predictions)]
  pred_val <- as.numeric(substring(prediction_class_key,11))
  if (length(pred_val)==0){
    pred_val <- c(0)
  }
  pred_val
}

#' Predict from a maximum likelihood classifier
#'
#' Designed to receive input of `df |>
#' train_test_split() |>
#' features_labels_select() |>
#' fit_mlc()`
#'
#' Can be used as a base `predict()` method or with [terra::predict].
#'
#' The object from [mlc()] and new data to predict which can either
#' be data frame or SpatRaster object. Needs to have the same bands and band
#' order as used in fitting the mlc. If input is a SpatRaster returns
#' SpatRaster, otherwise returns vector of class predictions.
#'
#' @param object a fitted mlc using [mlc()]
#' @param newdata a data.frame or SpatRaster of values to predict.
#'
#' @return numeric vector of predicted class values or 1 band SpatRaster
#' of the same.
#' @rdname predict.mlc
#' @export
#'
#' @examples
#' \dontrun{
#'  terra::predict(example_img, model=mlc, na.rm = TRUE)
#' }
#' @export
predict.mlc <- function(object, newdata, ...){
  if (inherits(newdata, "SpatRaster")){
    newdata_df <- terra::as.data.frame(newdata, na.rm=FALSE)
  } else if (inherits(newdata, "data.frame")){
    newdata_df <- newdata
  } else {cli::cli_abort("newdata must be data frame or SpatRaster")}
  class_predict <- purrr::map_int(1:nrow(newdata_df), .progress = TRUE,
                          \(i) .class_mlc(object, newdata_df[i,]))
  if (inherits(newdata, "SpatRaster")){
    pred_matrix <- matrix(class_predict,
                          nrow = terra::nrow(newdata),
                          ncol = terra::ncol(newdata), byrow = TRUE)
    pred_rast <- terra::rast(pred_matrix,
                       crs = terra::crs(newdata),
                       extent = terra::ext(newdata),
                       names = "class")
    names(pred_rast) <- "class"
    return(pred_rast)
  }
  class_predict
}
