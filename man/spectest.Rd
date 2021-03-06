\name{spectest}
\alias{spectest}
\title{Utility function for null hypothesis tests on Zelig model objects}
\usage{
  spectest(model, null=0, var, onetail=FALSE)
}
\arguments{
\item{model}{Output of a Zelig model.}
\item{null}{Null value of the hypothesis test.}
\item{var}{Variable name on whose coefficient to conduct hypothesis test.}
\item{onetail}{If TRUE, calculates a one-tail test, otherwise two-tails.} 
}
\value{
  A p-value for the null hypothesis.
}
\description{
  The \code{spectest} utility allows users to easily conduct a null hypothesis
  test on the output of a Zelig model.
}
\author{
  Vito D'Orazio
}


