
#' Crop a raster using bounding box coords
#'
#' @param input_raster `terra::rast` raster to be cropped.
#' @param xmin x min coordinate in same crs as `input_raster`
#' @param ymin y min coordinate in same crs as `input_raster`
#' @param xmax xmax min coordinate in same crs as `input_raster`
#' @param ymax xmax min coordinate in same crs as `input_raster`
#' @param out_file Full path and file name to write cropped image to.
#'
#' @return Cropped `terra::rast`
#' @export
#'
#' @examples
#' \dontshow{.old_wd <- setwd(tempdir())}
#' # create raster
#' rast <- terra::rast(
#'   ncols = 10, nrows = 10, xmin = 0, xmax = 10, ymin = 0,
#'   ymax = 10, crs = "EPSG:4326", vals = runif(100, 0, 1),
#'   names = c("b1")
#' )
#' # crop
#' crop_with_box(rast,
#' xmin = 2,
#' ymin = 2,
#' xmax = 5,
#' ymax = 5,
#' out_file = "test.tif")
#' \dontshow{setwd(.old_wd)}
#'
crop_with_box <- function(input_raster, xmin, ymin, xmax, ymax, out_file) {
  poly <- terra::ext(xmin, xmax, ymin, ymax)
  if (terra::intersect(poly, terra::ext(input_raster)) != poly) {
    cli::cli_abort("coordinates not within raster extent")
  }
  terra::crop(input_raster,
    poly,
    mask = FALSE,
    filename = out_file
  )
}
