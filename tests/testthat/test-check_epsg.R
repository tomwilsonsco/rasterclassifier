test_that("epsg NA code works", {
  rast1 <- terra::rast(
    ncols = 10, nrows = 10, xmin = 0, xmax = 10, ymin = 0,
    ymax = 10
  )
  expect_error(check_epsg(rast1), "rast1 does not have a valid epsg code.")
})

test_that("epsg mismatch code works", {
  rast1 <- terra::rast(
    ncols = 10, nrows = 10, xmin = 0, xmax = 10, ymin = 0,
    ymax = 10, crs = "EPSG:4326"
  )
  rast2 <- terra::rast(
    ncols = 10, nrows = 10, xmin = 0, xmax = 10, ymin = 0,
    ymax = 10, crs = "EPSG:3857"
  )

  expect_error(check_epsg(rast1, rast2), strwrap("CRS EPSG code mismatch:
  rast1: 4326 and rast2: 3857"))
})
