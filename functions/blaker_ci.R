acceptbin <- function(x, n, p) {
  p1 <- 1 - pbinom(x - 1, n, p)
  p2 <- pbinom(x, n, p)
  a1 <- p1 + pbinom(qbinom(p1, n, p) - 1, n, p)
  a2 <- p2 + 1 - pbinom(qbinom(1 - p2, n, p), n, p)
  min(a1, a2)
}

blaker_ci <- function(x, n, conf_level = 0.95, tolerance = 1e-04) {
  lower <- 0
  upper <- 1
  if (x != 0) {
    lower <- qbeta((1-conf_level)/2, x, n-x+1)
    while(acceptbin(x, n, lower) > (1 - conf_level)) {
      lower <- lower + tolerance
    }
  }
  if (x != n) {
    upper <- qbeta(1 - (1-conf_level)/2, x + 1, n-x)
    while(acceptbin(x, n, upper) > (1 - conf_level)) {
      upper <- upper + tolerance
    }
  }
  c(lower, upper)
}
# acceptinterval(0, 20, 0.95)
# acceptinterval(0, 400, 0.95)
