
extract_per_class <- function(class_value,
                              input_raster,
                              training_shapes,
                              training_class_col) {
  class_training <- training_shapes[training_shapes[[training_class_col]]
                                    ==class_value, ]

  pixel_vals <- terra::extract(input_raster, class_training)

  pixel_vals[[training_class_col]] <- class_value
  pixel_vals
}

check_class_col <- function(training_shapes, class_column){
  if (! class_column %in% colnames(training_shapes)){
    training_shapes[[class_column]] <- 0
  }
  training_shapes
}


get_distinct_classes <- function(training_shapes, training_class_col) {
  distinct_vals <- unique(training_shapes[[training_class_col]])

  if (is.factor(distinct_vals)) {
    distinct_vals <- as.character(distinct_vals)
  }
  distinct_vals
}



#' Extract pixels from input raster using input training data.
#'
#' @param input_raster terra::rast object for raster.
#' @param training_shapes sf spatial dataframe or terra::vect polygons for
#' training data.
#' @param training_class_col  Optional column_name in training shapes showing
#' the class of each training data record. If not specified an "ml_class"
#' column is added with all values of 0.
#'
#' @return Dataframe of pixel values per class.
#' @export
#'
#' @examples
#' # create raster
#' rast <- terra::rast(
#' ncols = 10, nrows = 10, xmin = 0, xmax = 10, ymin = 0,
#' ymax = 10, crs = "EPSG:4326", vals=runif(100, 0, 1),
#' names=c("b1")
#' )
#'
#' # create polygon vector layer
#'p <- list(sf::st_polygon(list(cbind(c(0,1,1,0,0), c(0,0,1,1,0)))),
#'           sf::st_polygon(list(cbind(c(8, 9, 9, 8, 8), c(8, 8, 9, 9, 8)))))
#'
#' vect <- sf::st_as_sf(data.frame(id=c(1,2),
#' geom=sf::st_sfc(p, crs="EPSG:4326")))
#'
#' # extract raster pixels where intersect vector later
#' extract_pixels(rast, vect)
extract_pixels <- function(input_raster,
                           training_shapes,
                           training_class_col = "ml_class") {

  is_raster(input_raster)

  is_vector(training_shapes)

  check_epsg(input_raster, training_shapes)

  training_shapes <- check_class_col(training_shapes, training_class_col)

  distinct_classes <- get_distinct_classes(training_shapes, training_class_col)

  purrr::map_df(distinct_classes,
    extract_per_class,
    input_raster = input_raster,
    training_shapes = training_shapes,
    training_class_col = training_class_col
  )

}
