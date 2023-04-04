calc_metrics <- function(pred_y, actual_y, micro = TRUE) {
  confusion_matrix <- table(pred_y, actual_y)
  if (nrow(confusion_matrix) == 2) {
    tp <- confusion_matrix[2, 2]
    fp <- confusion_matrix[2, 1]
    fn <- confusion_matrix[1, 2]

    precision <- tp / sum(tp, fp)
    recall <- tp / sum(tp, fn)
  } else if (nrow(confusion_matrix > 2)) {
    tp <- diag(confusion_matrix)
    row_sum <- rowSums(confusion_matrix)
    col_sum <- colSums(confusion_matrix)
    precision <- mean(tp / row_sum)
    recall <- mean(tp / col_sum)
  } else {
    cli::abort("There is only one class: {unique(actual_y)}")
  }
  f1_score <- 2 * (precision * recall) / (precision + recall)
  message("Confusion matrix")
  print(confusion_matrix)
  list(
    confusion_matrix = confusion_matrix,
    precision = precision,
    recall = recall,
    f1_score = f1_score
  )
}

get_ml_metrics <- function(pred_y, actual_y, micro = TRUE) {
  calc_metrics(pred_y, actual_y, micro)
}
