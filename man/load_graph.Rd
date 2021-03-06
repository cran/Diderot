\name{load_graph}
\alias{load_graph}
\alias{Citation Graph Loading}
\concept{Citation Graph}
\concept{Citation Network}
\concept{Bibliographic Network}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function to load a citation graph
}
\description{
This function loads a citation graph saved on the filesystem.
}
\usage{
load_graph(filename)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{filename}{
File to load
}
}
%%\details{
%%  ~~ If necessary, more details than the description above ~~
%%}
\value{
Returns a graph object.
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
%%\references{
%% ~put references to the literature/web site here ~
%%}
\author{
Christian Vincenot (christian@vincenot.biz)
}
\note{
This function basically supports only graph previously saved with Diderot's save_graph. However, as the file is actually a graphml file handled by igraph, advanced users may use this function on appropriate graphs created elsewhere, as long as they respect Diderot's structure (presence of a "Corpus"" field, etc).
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{save_graph}}
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
\dontshow{
save_graph(gr, file.path(tempdir(),"test.csv"))
unlink(file.path(tempdir(),"test.csv"))
}
\dontrun{
save_graph(gr, "Saved.graphml")

# Load saved graph
gr<-load_graph("Saved.graphml")
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
