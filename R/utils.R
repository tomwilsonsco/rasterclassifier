.is_raster <- function(input_raster) {
  match_class <- intersect(class(input_raster), c("raster", "SpatRaster"))
  if (length(match_class) == 0) {
    cli::cli_abort(
      "{deparse(match.call()[[2]])} is not a raster or SpatRaster"
    )
  }
}

.is_vector <- function(training_shapes) {
  match_class <- intersect(class(training_shapes), c("data.frame"))
  if (length(match_class) == 0) {
    cli::cli_abort("{deparse(match.call()[[2]])} is not class data.frame")
  }
}
