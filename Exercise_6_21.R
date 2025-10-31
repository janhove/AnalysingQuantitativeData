# Exercise 6.21: Robustness of the t method
library(tidyverse)

uniform_one_run <- function(n, min, max, conf_level) {
  x <- runif(n, min, max)
  ci <- t.test(x, conf.level = conf_level)$conf.int
  popmean <- (min + max) / 2
  ci[1] <= popmean & popmean <= ci[2]
}

sim <- function(fun, M = 20000, ...) {
  args <- list(...)
  replicate(M, do.call(fun, args = args)) |> 
    mean()
}

# for one set of values
sim(uniform_one_run, n = 9, min = -12, max = 2, conf_level = 0.7)

# for multiple sets of values
values <- expand.grid(
  n = c(3, 9, 27),
  conf_level = c(0.5, 0.7, 0.9)
)
values$coverage <- 0
for (i in 1:nrow(values)) {
  values$coverage[i] <- 
    sim(uniform_one_run, n = values$n[i],
        min = -12, max = 2, conf_level = values$conf_level[i])
}
values |> 
  ggplot(aes(x = factor(n),
             y = coverage,
             colour = factor(conf_level),
             group = factor(conf_level))) +
  geom_point() +
  geom_line() +
  scale_x_continuous(breaks = values$n |> unique(),
                     labels = values$n |> unique()) +
  scale_y_continuous(breaks = values$conf_level |> unique(),
                     labels = values$conf_level |> unique(),
                     limits = c(0.3, 1))

# Same for chisq
chisq_one_run <- function(n, df, conf_level) {
  x <- rchisq(n, df)
  ci <- t.test(x, conf.level = conf_level)$conf.int
  popmean <- df
  ci[1] <= popmean & popmean <= ci[2]
}
values <- expand.grid(
  n = c(3, 9, 27),
  conf_level = c(0.5, 0.7, 0.9),
  df = c(1, 3, 9)
)
values$coverage <- 0
for (i in 1:nrow(values)) {
  values$coverage[i] <- 
    sim(chisq_one_run, n = values$n[i],
        df = values$df[i], conf_level = values$conf_level[i])
}
values |> 
  ggplot(aes(x = n,
             y = coverage,
             colour = conf_level |> factor(),
             group = conf_level |> factor())) +
  geom_point() +
  geom_line() +
  facet_wrap(vars(df)) +
  scale_x_continuous(breaks = values$n |> unique(),
                     labels = values$n |> unique()) +
  scale_y_continuous(breaks = values$conf_level |> unique(),
                     labels = values$conf_level |> unique(),
                     limits = c(0.3, 1))

# Um es abzulernen: exponentiell
exp_one_run <- function(n, rate, conf_level) {
  x <- rexp(n, rate)
  ci <- t.test(x, conf.level = conf_level)$conf.int
  popmean <- 1/rate
  ci[1] <= popmean & popmean <= ci[2]
}
values <- expand.grid(
  n = c(3, 9, 27),
  conf_level = c(0.5, 0.7, 0.9),
  rate = c(1/3, 1, 3)
)
values$coverage <- 0
for (i in 1:nrow(values)) {
  values$coverage[i] <- 
    sim(exp_one_run, n = values$n[i],
        rate = values$rate[i], conf_level = values$conf_level[i])
}
values |> 
  ggplot(aes(x = n,
             y = coverage,
             colour = conf_level |> factor(),
             group = conf_level |> factor())) +
  geom_point() +
  geom_line() +
  facet_wrap(vars(rate)) +
  scale_x_continuous(breaks = values$n |> unique(),
                     labels = values$n |> unique()) +
  scale_y_continuous(breaks = values$conf_level |> unique(),
                     labels = values$conf_level |> unique(),
                     limits = c(0.3, 1))

# Um es abzulernen: t(2)-Verteilung (hat keine Varianz)
t2_one_run <- function(n, conf_level) {
  x <- rt(n, 2)
  ci <- t.test(x, conf.level = conf_level)$conf.int
  popmean <- 0
  ci[1] <= popmean & popmean <= ci[2]
}
values <- expand.grid(
  n = c(3, 9, 27, 81, 243),
  conf_level = c(0.5, 0.7, 0.9)
)
values$coverage <- 0
for (i in 1:nrow(values)) {
  values$coverage[i] <- 
    sim(t2_one_run, n = values$n[i],
        conf_level = values$conf_level[i])
}
values |> 
  ggplot(aes(x = n,
             y = coverage,
             colour = conf_level |> factor(),
             group = conf_level |> factor())) +
  geom_point() +
  geom_line() +
  scale_x_log10(breaks = values$n |> unique(),
                     labels = values$n |> unique()) +
  scale_y_continuous(breaks = values$conf_level |> unique(),
                     labels = values$conf_level |> unique(),
                     limits = c(0.3, 1))
