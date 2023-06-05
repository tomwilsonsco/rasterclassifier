#' Example point features for use with sample raster `example_s2`.
#'
#' Point capture of some forest and non-forest for use as
#' training data for example code testing.\cr
#' Manually captured from Sentinel 2 image for testing `rasterclassifier`
#' functions.\cr
#'
#' Copernicus Sentinel data 2021.
#' Retrieved from ASF DAAC 15 April 2022, processed by ESA.
#'
#'
#' @format ## `example_pt`
#' Simple feature collection with 27 features and 1 field.
#' Geometry type: POINT.
#' \describe{
#'   \item{ml_class}{1 for forest and 0 for non-forest features}

#' }
#' @source <https://developers.google.com/earth-engine/datasets/catalog/COPERNICUS_S2_SR>
"example_pt"
