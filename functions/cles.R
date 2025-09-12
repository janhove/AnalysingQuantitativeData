# Naive Berechnung des common-language effect size.
# Laufzeit in O(n1n2), also grundsätzlich quadratisch.
.h <- function(x) {
  if(isTRUE(all.equal(x, 0))) {
    return(1/2)
  }
  return(as.numeric(x > 0))
}
.h_vec <- Vectorize(.h)
cles <- function(x, y) {
  comparisons <- outer(x, y, FUN = "-") |>
    as.vector()
  .h_vec(comparisons) |> mean()
}
