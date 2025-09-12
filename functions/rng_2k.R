# Random number generator with support k = 1, 2, ...
# and Prob(X = k) = 1/2^k. This is just a geometric
# distribution with support k = 1, 2, ... and p = 1/2.
# R's Geometric functions are for support k = 0, 1, 2, ..., though.

drng_2k <- function(x) {
  dgeom(x - 1, 1/2)
}
 
prng_2k <- function(q) {
	pgeom(q - 1, 1/2)
}

qrng_2k <- function(p) {
	qgeom(p, 1/2) + 1
}

rrng_2k <- function(n) {
  rgeom(n, 1/2) + 1
}