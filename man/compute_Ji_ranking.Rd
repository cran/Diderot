\name{compute_Ji_ranking}
\alias{compute_Ji_ranking}
\alias{Ji Ranking}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function to compute the Ji metric ranking for publications in a citation graph.
}
\description{
This function computes the Ji metric for each graph node (i.e. publication). This metric indicates how much a publication is cited simulteaneously by both corpora and is thus important for cross-fertilization between the two communities. 
}
\usage{
compute_Ji_ranking(gr, labels, infLimitYear, supLimitYear, write_to_graph=F)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
\item{gr}{Citation graph}
\item{labels}{Labels (i.e. names) of the two corpora featured in the graph.}
\item{infLimitYear}{Start year of the time window considered (included)}
\item{supLimitYear}{End year of the time window considered (*excluded*)}
\item{write_to_graph}{Flag to indicate whether to write results to the graph (i.e. save Ji values as node attributes).}
}
%%\details{
%%  ~~ If necessary, more details than the description above ~~
%%}
\value{
If write_to_graph is FALSE, returns a list of entries (authors, title, year, corpus, citations from corpus 1, citation from corpus 2, Ji) sorted by decreasing Ji. Else, returns the graph given as input to which Ji are added as node attributes.
}
%%\references{
%% ~put references to the literature/web site here ~
%%}
\author{
Christian Vincenot (christian@vincenot.biz)
}
%%\note{
%%  ~~further notes~~
%%}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{build_graph}}, \code{\link{precompute_heterocitation}}, \code{\link{compute_Ji}}
}
\examples{
\dontshow{
# Generate corpora
corp1<-data.frame(Authors=paste("Author",round(runif(45,1,20)),sep=""),Title=paste("Title",seq(1,45), sep=""), Year=round(runif(45,1990,2018)), References=NA,stringsAsFactors=FALSE)
corp2<-data.frame(Authors=paste("Author",round(runif(65,15,35)),sep=""),Title=paste("Title",seq(46,110), sep=""), Year=round(runif(65,1990,2018)), References=NA, stringsAsFactors=FALSE)

len1<-length(corp1$Authors)
len2<-length(corp2$Authors)
lnall<-len1+len2

for (i in seq(1:lnall)) {
  str<-""
  for (j in seq(1:round(runif(1,1,4)))) {
    rn<-round(runif(1,1,lnall))
    if (rn > len1) { 
      str<-sprintf("\%s \%s. \%d. \%s;", str, corp2$Authors[rn-len1], corp2$Year[rn-len1], corp2$Title[rn-len1])
    } else {
      str<-sprintf("\%s \%s. \%d. \%s;", str, corp1$Authors[rn], corp1$Year[rn], corp1$Title[rn])
    }
  }
  if (i>len1) {
    corp2$References[i-len1]<-str
  } else corp1$References[i]<-str
}

# Create joint references
for (i in seq(1:5)) {
  corp1<-rbind(corp1, corp2[runif(1,1,len2),])
  corp2<-rbind(corp2, corp1[runif(1,1,len1),])
}

# Add duplicate entry
corp1<-rbind(corp1, corp1[1,])

tempfi1<-file.path(tempdir(),"corpus1.csv")
tempfi2<-file.path(tempdir(),"corpus2.csv")
write.csv(corp1, tempfi1)
write.csv(corp2, tempfi2)
}

labels<-c("Corpus1","Corpus2")

# Build a bibliographical dataset from Scopus exports
db<-create_bibliography(corpora_files=c(tempfi1,tempfi2), 
                        labels=labels, keywords=NA)
\dontshow{unlink(c(tempfi1, tempfi2))}

# Build graph
gr<-build_graph(db=db,small.year.mismatch=TRUE, attrs=c("Corpus","Year","Authors"), nb.cores=1)

# Compute Ji ranking
compute_Ji_ranking(gr, labels, 1990, 2018)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
