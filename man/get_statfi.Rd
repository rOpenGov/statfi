\name{get_statfi}
\alias{get_statfi}
\title{Get PC Axis data with custom preprocessing for PC Axis
files from Statistics Finland (Tilastokeskus) http://www.stat.fi/}
\usage{
  get_statfi(url, format = "px", verbose = TRUE)
}
\arguments{
  \item{url}{or local file name of the StatFi file}

  \item{format}{One of the following: "px", "csv", "xml".
  Specifies the desired format of the source file.}

  \item{verbose}{verbose

  Returns:}
}
\value{
  data.frame
}
\description{
  Arguments:
}
\details{
  If the reading of PX file fails, CSV is used instead.
}
\examples{
# px <- get_statfi("http://pxweb2.stat.fi/database/StatFin/vrm/synt/080_synt_tau_203.px")
}
\author{
  Leo Lahti \email{louhos@googlegroups.com}
}
\references{
  See citation("statfi")
}
\keyword{utilities}

