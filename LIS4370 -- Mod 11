tukey.outlier <- function(x) {
  # Pretend outlier if value > mean + 2*sd (Dummy Function for Logic testing)
  upper <- mean(x) + 2 * sd(x)
  lower <- mean(x) - 2 * sd(x)
  return(x < lower | x > upper)
}

tukey_multiple <- function(x) {
  outliers <- array(TRUE, dim = dim(x))
  
  for (j in 1:ncol(x)) {
    if (is.numeric(x[[j]])) {
      outliers[, j] <- outliers[, j] & tukey.outlier(x[[j]])
    } else {
      outliers[, j] <- FALSE
    }
  }
  
  outlier.vec <- vector(length = nrow(x))
  
  for (i in 1:nrow(x)) {
    outlier.vec[i] <- all(outliers[i, ])
  }
  
  return(outlier.vec)
}

library(readr)
BostonHousing <- read_csv("BostonHousing.csv")

debug(tukey_multiple)
tukey_multiple(BostonHousing) 
undebug(tukey_multiple)

tukey_multiple(BostonHousing)
