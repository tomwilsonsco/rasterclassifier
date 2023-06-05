#' Example Sentinel 2 image as `raster::brick()`
#'
#' Small 3 km by 1.5 km Sentinel 2 image over Scotland\cr
#' Image date 21 April 2021
#'
#' Copernicus Sentinel data 2021.
#' Retrieved from ASF DAAC 15 April 2022, processed by ESA.
#'
#' Created with `raster::brick()` as at time of writing
#' `terra::rast()` SpatRaster
#' objects cannot be stored as rda files.
#'
#' @format ## `example_s2`
#' A RasterBrick 147, 300, 44100, 5  (nrow, ncol, ncell, nlayers):
#' \describe{
#'   \item{B2}{Blue}
#'   \item{B3}{Green}
#'   \item{B4}{Red}
#'   \item{B8}{Near Infra Red}
#'   \item{B11}{Short Wave Infra Red}
#'   ...
#' }
#' @source <https://developers.google.com/earth-engine/datasets/catalog/COPERNICUS_S2_SR>
"example_s2"
