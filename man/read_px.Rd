\name{read_px}
\alias{read_px}
\title{read_px}
\usage{
read_px(filename, encoding = "latin1", na.strings = c("\\".\\"", "\\"..\\"",
  "\\"...\\"", "\\"....\\""))
}
\arguments{
  \item{filename}{filename}

  \item{encoding}{encoding}

  \item{na.strings}{na.strings}
}
\value{
px object
}
\description{
Fixed version of read.px from pxR package
}
\examples{
\dontrun{px <- read_px("http://pxweb2.stat.fi/database/StatFin/vrm/synt/080_synt_tau_203.px")}
}
\author{
Contact: Leo Lahti \email{louhos@googlegroups.com}
}
\references{
See citation("statfi")
}
\keyword{utilities}

