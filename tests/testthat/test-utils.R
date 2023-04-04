test_that("check is raster works", {
  test_df <- data.frame(a = c(1, 2, 3))
  expect_error(is_raster(test_df), "test_df is not a raster or SpatRaster")
})


test_that("check is vector works", {
  test <- sf::st_point(c(1, 2))
  expect_error(is_vector(test), "test is not class data.frame")
})
