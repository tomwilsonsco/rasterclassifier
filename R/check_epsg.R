#' Check raster or vector objects have a valid crs epsg code
#' and if two inputs that they match.
#'
#' @param x First raster or vector layer to check.
#' @param y Optional second raster or vector layer to compare.
#'
#' @return TRUE if epsg codes found and if they match when two inputs.
#' @export
#'
#' @examples
#' rast1 <- terra::rast(
#'   ncols = 10, nrows = 10, xmin = 0, xmax = 10, ymin = 0,
#'   ymax = 10, crs = "EPSG:4326"
#' )
#' rast2 <- terra::rast(
#'   ncols = 10, nrows = 10, xmin = 0, xmax = 10, ymin = 0,
#'   ymax = 10, crs = "EPSG:3857"
#' )
#'
#' check_epsg(rast1, rast2)
check_epsg <- function(x, y = NULL) {
  epsg_x <- terra::crs(x, describe = TRUE)$code

  # For printing input arg value
  x_val <- deparse(match.call()[[2]])

  if (is.na(epsg_x)) {
    cli::cli_abort("{x_val}
                   does not have a valid epsg code.")
  }

  if (!is.null(y)) {
    epsg_y <- terra::crs(y, describe = TRUE)$code

    y_val <- deparse(match.call()[[3]])


    if (is.na(epsg_y)) {
      cli::cli_abort("{y_val}
                   does not have a valid epsg code.")
    } else if (epsg_x != epsg_y) {
      cli::cli_abort("CRS EPSG code
                   mismatch: {x_val}: {epsg_x} and {y_val}: {epsg_y}")
    } else {
      (TRUE)
    }
  } else {
    TRUE
  }
}
