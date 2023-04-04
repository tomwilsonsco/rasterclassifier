calc_metrics <- function(pred_y, actual_y, micro = TRUE) {
  # Ensure a square matrix
  actual_y <- factor(actual_y)
  pred_y <- factor(pred_y, levels = levels(actual_y))

  confusion_matrix <- table(pred_y, actual_y)

  # Binary classification situation
  if (ncol(confusion_matrix) == 2) {
    tp <- confusion_matrix[2, 2]
    tn <- confusion_matrix[1, 1]
    fp <- confusion_matrix[2, 1]
    fn <- confusion_matrix[1, 2]

    precision <- tp / sum(tp, fp)
    recall <- tp / sum(tp, fn)

    overall <- sum(tp, tn) / sum(tp, tn, fp, fn)

    # Multiclass classification situation
  } else if (ncol(confusion_matrix > 2)) {
    tp <- diag(confusion_matrix)

    row_sum <- rowSums(confusion_matrix)
    col_sum <- colSums(confusion_matrix)

    precision <- mean(tp / row_sum)
    recall <- mean(tp / col_sum)

    overall <- sum(tp) / sum(row_sum)

    # If just one class in actual_y
  } else {
    cli::abort("There is only one class: {levels(actual_y)}")
  }

  f1_score <- 2 * (precision * recall) / (precision + recall)
  message("Confusion matrix")

  print(confusion_matrix)

  # Output a list of metrics
  list(
    confusion_matrix = confusion_matrix,
    precision = precision,
    recall = recall,
    f1_score = f1_score,
    overall = overall
  )
}

get_ml_metrics <- function(pred_y, actual_y, micro = TRUE) {
  calc_metrics(pred_y, actual_y, micro)
}
