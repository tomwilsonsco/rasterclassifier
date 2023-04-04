shuffle_df <- function(input_df, seed_value = NULL) {
  if (!is.null(seed_value)) {
    set.seed(seed_value)
  }
  shuffled_rows <- sample(nrow(input_df))
  input_df[shuffled_rows, ]
}



#' Split input dataframe into training and testing dataframes.
#'
#' @param training_df Input dataframe to be split.
#' @param training_proportion What proportion of nrows should be in training.
#' Defaults to 0.75.
#' @param shuffle Should the dataframe be shuffled before splitting. Defaults
#' to TRUE.
#' @param seed_value Seed value used in set.seed to ensure shuffling and
#' training testing splits are the same each time.
#'
#' @return list with a train and test dataframe as subsets of the input df.
#' @export
#'
#' @examples
#' train_test_split(iris)
train_test_split <- function(training_df,
                             training_proportion = 0.75,
                             shuffle = TRUE,
                             seed_value = NULL) {
  training_df$id <- 1:nrow(training_df)

  if (shuffle) {
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
