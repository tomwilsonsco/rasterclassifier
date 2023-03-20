test_that("polygon extract add class attribute works", {
  expect_df <- data.frame(
    b1 = c(0.1306957, 0.3279207),
    ml_class = c(0, 0)
  )

  set.seed(123)
  rast <- terra::rast(
    ncols = 10, nrows = 10, xmin = 0, xmax = 10, ymin = 0,
    ymax = 10, crs = "EPSG:4326",
    names = c("b1"),
    vals = runif(100, 0, 1)
  )

  p <- list(
    sf::st_polygon(list(cbind(c(0, 1, 1, 0, 0), c(0, 0, 1, 1, 0)))),
    sf::st_polygon(list(cbind(c(8, 9, 9, 8, 8), c(8, 8, 9, 9, 8))))
  )


  vect <- sf::st_as_sf(data.frame(id = c(1, 2), geom = sf::st_sfc(p, crs = "EPSG:4326")))

  expect_equal(extract_pixels(rast, vect), expect_df, tolerance = 0.001)
})

test_that("point extract add class attribute works", {
  expect_df <- data.frame(
    b1 = c(0.4089769, 0.8924190, 0.4753166, 0.3517979),
    ml_class = c(0, 0)
  )

  set.seed(123)
  rast <- terra::rast(
    ncols = 10, nrows = 10, xmin = 0, xmax = 10, ymin = 0,
    ymax = 10, crs = "EPSG:4326",
    names = c("b1"),
    vals = runif(100, 0, 1)
  )

  set.seed(123)
  df <- data.frame(x = runif(4, 0, 10))
  set.seed(321)
  df$y <- runif(4, 0, 10)
  pt_vect <- sf::st_as_sf(df, coords = c("x", "y"), crs = "EPSG:4326")


  expect_equal(extract_pixels(rast, pt_vect), expect_df, tolerance = 0.001)
})


test_that("point extract existing class col works", {
  expect_df <- data.frame(
    b1 = c(0.4089769, 0.8924190, 0.4753166, 0.3517979),
    train_class = c(0, 0, 1, 1)
  )

  set.seed(123)
  rast <- terra::rast(
    ncols = 10, nrows = 10, xmin = 0, xmax = 10, ymin = 0,
    ymax = 10, crs = "EPSG:4326",
    names = c("b1"),
    vals = runif(100, 0, 1)
  )

  set.seed(123)
  df <- data.frame(x = runif(4, 0, 10), train_class = c(0, 0, 1, 1))
  set.seed(321)
  df$y <- runif(4, 0, 10)
  pt_vect <- sf::st_as_sf(df, coords = c("x", "y"), crs = "EPSG:4326")


  expect_equal(extract_pixels(rast, pt_vect, "train_class"),
    expect_df,
    tolerance = 0.001
  )
})
