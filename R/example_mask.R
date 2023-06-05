#' Example polygon feature to be as mask for use with sample raster
#' `example_s2()`.
#'
#' Basic digitising of an example mask area over the sample Sentinel 2 image.
#' Manually captured from Sentinel 2 image for testing `rasterclassifier`
#' functions.\cr
#'
#' Copernicus Sentinel data 2021.
#' Retrieved from ASF DAAC 15 April 2022, processed by ESA.
#'
#'
#' @format ## `example_mask`
#' Simple feature collection with 1 feature and 0 fields.
#' Geometry type: POLYGON.
#' \describe{
#'   \item{ml_class}{1 for forest and 0 for non-forest features}

#' }
#' @source <https://developers.google.com/earth-engine/datasets/catalog/COPERNICUS_S2_SR>
"example_mask"
