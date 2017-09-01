\name{p_value_Dx}
\alias{p_value_Dx}
\alias{Heterocitation Significance}
\concept{Heterocitation Balance}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Function to evaluate the significance of the heterocitation balance value}
\description{
This function performs Monte Carlo runs to evaluate the significance of the heterocitation balance value (Dx). Practically, it performs random permutations of corpus tags in the graph provided and computes the heterocitation balance on the new graph. This operation is repeated over several iterations (set through the "rep" argument) and provides the distribution of Dx values obtained at random. This can then be compared with the Dx value obtained for the original graph to evaluate whether it could merely be the result of chance.
}
\usage{
p_value_Dx(gr, labels, infYearLimit, supYearLimit, rep = 20)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{gr}{Graph file (created with build_graph)}
  \item{labels}{List of the names of the two corpora studied (e.g. c("Computer Science", "Mathematics")), present in the "Corpus" attribute}
  \item{infYearLimit}{Minimum year considered in this study}
  \item{supYearLimit}{Maximum year considered in this study}
  \item{rep}{Number of Monte Carlo iterations}
}
%\details{
%%  ~~ If necessary, more details than the description above ~~
%}
\value{
Plots the histograms of distribution of Dx values generated through random permutations of corpus tags among the records.
Returns a list containing:
\item{Dx1}{Dx value for corpus 1 per iteration}
\item{Dx1}{Dx value for corpus 2 per iteration}
\item{DxALL}{Global Dx value per iteration}
}
%\references{
%% ~put references to the literature/web site here ~
%}
\author{
Christian Vincenot (christian@vincenot.biz)
}
%\note{
%%  ~~further notes~~
%}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{heterocitation}}
}
%\examples{}
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
