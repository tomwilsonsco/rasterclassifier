.calc_f1_score <- function(precision, recall) {
  2 * (precision * recall) / (precision + recall)
}

# Binary classification situation
.binary_metrics <- function(confusion_matrix) {
  tp <- confusion_matrix[2, 2]
  tn <- confusion_matrix[1, 1]
  fp <- confusion_matrix[2, 1]
  fn <- confusion_matrix[1, 2]

  precision <- tp / sum(tp, fp)
  recall <- tp / sum(tp, fn)

  list(
    confusion_matrix = confusion_matrix,
    precision = precision,
    recall = recall,
    f1_score = .calc_f1_score(precision, recall),
    overall = sum(tp, tn) / sum(tp, tn, fp, fn)
  )
}

# Multiclass situation - macro precision and recall calc
.multiclass_metrics <- function(confusion_matrix) {
  tp <- diag(confusion_matrix)

  row_sum <- rowSums(confusion_matrix)
  col_sum <- colSums(confusion_matrix)

  precision <- mean(tp / col_sum)
  recall <- mean(tp / row_sum)

  list(
    confusion_matrix = confusion_matrix,
    precision = precision,
    recall = recall,
    f1_score = .calc_f1_score(precision, recall),
    overall = sum(tp) / sum(confusion_matrix)
  )
}

.get_metrics <- function(pred_y, actual_y) {
  # Ensure a square matrix
  actual_y <- factor(actual_y)
  pred_y <- factor(pred_y, levels = levels(actual_y))

  confusion_matrix <- table(pred_y, actual_y)

  if (ncol(confusion_matrix)==2) {
    metrics <- .binary_metrics(confusion_matrix)
  } else if (ncol(confusion_matrix) > 2) {
    metrics <- .multiclass_metrics(confusion_matrix)
    # If just one class in actual_y
  } else {
    cli::cli_abort("There is only one class: {levels(actual_y)}")
  }
  metrics
}

#' Calculate common classification metrics from prediction and actual vectors
#'
#' @param pred_y A vector of prediction class values. Should be factor
#' or integer.
#' @param actual_y A vector of actual class values. Should be the same datatype
#' and of the same length as `pred_y`.
#' .
#' @return A list of metrics - confusion matrix, precision, recall, F1 Score
#' and overall accuracy.
#' @export
#'
#' @examples
#' actual_y <- iris$Species
#' pred_y <- sample(actual_y, length(actual_y), replace = TRUE)
#' get_classif_metrics(actual_y, pred_y)
get_classif_metrics <- function(pred_y, actual_y) {
  .get_metrics(pred_y, actual_y)
}
