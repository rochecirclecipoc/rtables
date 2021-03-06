% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/colby_constructors.R
\name{analyze_colvars}
\alias{analyze_colvars}
\title{Generate Rows Analyzing Different Variables Across Columns}
\usage{
analyze_colvars(
  lyt,
  afun,
  format = NULL,
  nested = TRUE,
  extra_args = list(),
  indent_mod = 0L,
  inclNAs = FALSE
)
}
\arguments{
\item{lyt}{layout object pre-data used for tabulation}

\item{afun}{function or list. Function(s) to be used to calculate the values in each column.  the list will be repped out as needed and matched by position with the columns during tabulation.}

\item{format}{FormatSpec. Format associated with this split. Formats can be declared via strings (\code{"xx.x"}) or function. In cases such as \code{analyze} calls, they can character vectors or lists of functions.}

\item{nested}{boolean, Add this as a new top-level split  (defining a new subtable directly under root). Defaults to \code{FALSE}}

\item{extra_args}{list. Extra arguments to be passed to the tabulation function. Element position in thte list corresponds to the children of this split. Named elements in the child-specific lists are ignored if they do not match a formal argument of the ttabulation function.}

\item{indent_mod}{numeric. Modifier for the default indent position for the structure created by this function(subtable, content table, or row) \emph{and all of that structure's children}. Defaults to 0, which corresponds to the unmodified default behavior.}

\item{inclNAs}{boolean. Should observations with NA in the \code{var} variable(s) be included when performing this analysis. Defaults to \code{FALSE}}
}
\description{
Generate Rows Analyzing Different Variables Across Columns
}
\examples{

library(dplyr)
ANL <- DM \%>\% mutate(value = rnorm(n()), pctdiff = runif(n()))

## toy example where we take the mean of the first variable and the
## count of >.5 for the second.
colfuns <- list(function(x) rcell(mean(x), format = "xx.x"),
                function(x) rcell(sum(x > .5), format = "xx"))

l <- basic_table() \%>\%
    split_cols_by("ARM") \%>\%
    split_cols_by_multivar(c("value", "pctdiff")) \%>\%
    split_rows_by("RACE", split_label = "ethnicity", split_fun = drop_split_levels) \%>\%
    summarize_row_groups() \%>\%
    analyze_colvars(afun = colfuns)

l

build_table(l, ANL)


basic_table() \%>\% split_cols_by("ARM") \%>\%
    split_cols_by_multivar(c("value", "pctdiff"), varlabels = c("Measurement", "Pct Diff")) \%>\%
    split_rows_by("RACE", split_label = "ethnicity", split_fun = drop_split_levels) \%>\%
    summarize_row_groups() \%>\%
    analyze_colvars(afun = mean, format = "xx.xx") \%>\%
    build_table(ANL)
    
}
\seealso{
\code{\link{split_cols_by_multivar}}
}
\author{
Gabriel Becker
}
