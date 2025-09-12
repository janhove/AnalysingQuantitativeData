#' ---
#' author: 'your name'
#' title: 'script title'
#' date: 'yyyy/mm/dd'
#' output: 
#'  html_document:
#'    toc: true
#'    toc_float: true
#'    number_sections: true
#'    theme: sandstone
#'    highlight: tango
#'    dev: svg
#'    df_print: paged
#'    self_contained: true
#' ---

#' # Writing R Markdown reports
#' You can convert R scripts to reports by clicking _File > Compile Report..._
#' in RStudio.
#' For the current template, I've overridden some of the default settings
#' in order to make these reports easier on the eye, as you can see
#' in the first lines in the `template.R` file, which are separated
#' from the remainder of the script by `#' ---`.
#' 
#' As you can also see in the `template.R` file,
#' you can add running text to a report by prefacing it with `#' `.
#' (Don't forget the space!)
#' In such running text, you can use Markdown mark-up (see what they did
#' there?), for instance to use **boldface** or _italics_.
#' You can also insert URLs, such as this link
#' to the RMarkdown
#' [help page](https://bookdown.org/yihui/rmarkdown/html-document.html). 
#' Incidentally, you'll find further ways to customise compiled
#' R scripts on this page.
#' You'll easily find further Markdown syntax online.
#' 
#' Use sections and subsections to organise your reports, like so:
#' 
#' # Section
#' ## Subsection
#' ## Subsection
#' 
#' # Section
#' ## Subsection
#' ### Sub-subsection

#' R commands occurring a script will be executed when compiling the report.
#' This output will then be shown in the script.
#' If any commands can't be executed, for instance due to some syntax error,
#' the report won't be compiled.
#' So compiling your scripts also represents some form of quality control.
3^4

#' Plots can be generated as usual.
#' If needed, you can tweak their size manually,
#' as I do on the next line. Note that it starts with `#+ `.
#+ fig.width = 6, fig.height = 4
library(tidyverse)
data(iris)
ggplot(data = iris,
       aes(x = Sepal.Width,
           y = Petal.Width,
           colour = Species)) +
  geom_point()

#' Should you ever need it: You can include mathematical notation
#' in these reports using $\LaTeX$ syntax.
#' For instance:
#' $\sqrt{16} = 4$. Orr
#' $$p(y) = \frac{1}{\sqrt{2\pi}}\exp\left(- \frac{y^2}{2}\right).$$
#' Or
#' $$\cos(\pi t) = 
#' \begin{cases}
#'  1, & \textrm{if $t$ is even,} \\
#'  -1, & \textrm{if $t$ is uneven.}
#' \end{cases}
#' $$
#' 
#' You need to be connected to the Internet to render these $\LaTeX$
#' equations nicely.
#' 
#' # Software versions
devtools::session_info("attached")
