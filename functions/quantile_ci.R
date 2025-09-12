# Confidence bounds for quantiles

quantile_ci <- function(x, gamma, conf_level = 0.95, alternative = "two.sided") {
  alpha <- 1 - conf_level
  if (alternative == "two.sided") {
    alpha <- alpha / 2
  }
  x <- sort(x)
  n <- length(x)
  Fngamma <- pbinom(0:n, n, gamma)
  
  k <- which(Fngamma <= alpha) |> tail(1)
  ell <- which(Fngamma >= 1 - alpha) |> head(1)
  
  # Optimise boundaries
  while (pbinom(ell - 2, n, gamma) - pbinom(k - 1, n, gamma) >= conf_level) {
    ell <- ell - 1
  }
  while (pbinom(ell - 1, n, gamma) - pbinom(k, n, gamma) >= conf_level) {
    k <- k + 1
  }
  
  lwr <- ifelse(k == 0, -Inf, x[k])
  upr <- ifelse(ell == n, Inf, x[ell])
  
  if (alternative == "less") return(c(-Inf, upr))
  if (alternative == "greater") return(c(lwr, Inf))
  c(lwr, upr)
}

median_ci <- function(x, conf_level = 0.95, alternative = "two.sided") {
  quantile_ci(x = x, gamma = 0.5, 
              conf_level = conf_level, alternative = "alternative")
}
