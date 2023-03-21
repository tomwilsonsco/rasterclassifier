shuffle_df <- function(input_df, seed_value = NULL) {
  if (! is.null(seed_value)){
    set.seed(seed_value)
  }
  shuffled_rows <- sample(nrow(input_df))
  input_df[shuffled_rows, ]
}



train_test_split <- function(training_df,
                             training_proportion = 0.75,
                             shuffle = TRUE,
                             seed_value = NULL) {
  training_df$id <- 1:nrow(training_df)

  if (shuffle){
    training_df <- shuffle_df(training_df, seed_value)
  }

  if (!is.null(seed_value)) {
    set.seed(seed_value)
  }

  train <- training_df %>%
    dplyr::slice_sample(prop = training_proportion)

  test <- training_df %>%
    dplyr::anti_join(train, by = "id") %>%
    dplyr::select(-"id")

  train <- train %>%
    dplyr::select(-"id")


  list(train = train, test = test)
}
