//  $Id:  $

/**
  \mainpage 
  \author Steve Martell, University of British Columbia

  Copyright (c) 2010 Steve Martell

  License: BSD

  Updated example from Steve Martell: Creating custom libraries for use in ADMB
  ADMB Foundation Newsletter 1(4):3-4, Oct 2009.
  Open the "Files" tab and click dnorm.cpp to see the API documentation.
*/

#include <admodel.h>

/** Negative log-likelihood for the normal distributiond; scalar arguments.
\param x Observation, \f$x\f$.
\param mu Predicted value of \f$x\f$, \f$ \mu \f$.
\param std Estimated standard deviation of \f$x\f$, \f$\sigma\f$.
\return \f[
0.5\log(2\pi) + \log\sigma + 0.5\Big(\frac{x-\mu}{\sigma}\Big)^2
\f].
*/
dvariable dnorm(const double& x, const prevariable& mu, const prevariable& std)
{
  #ifdef M_PI
  double pi = M_PI;
  #else
  double pi = 3.14159265358979323844;
  #endif
  return 0.5*log(2.*pi) + log(std) + 0.5*square((x-mu)/std);
}

/** Negative log-likelihood for the normal distributiond; vector arguments.
All vectors must have identical starting and ending indices.
\param x Vector of observations, \f$x\f$.
\param mu Vector of predicted values of \f$x\f$, \f$ \mu \f$.
\param std Vector of estimated standard deviations of \f$x\f$, \f$\sigma\f$.
\return \f[
0.5n\log(2\pi) + \Sigma_i^n\log\sigma_i + 0.5\Sigma_i^n\Big(\frac{x_i-\mu_i}{\sigma_i}\Big)^2
\f]
where \f$n\f$ is the number of observations in #x.
*/
dvariable dnorm(const dvector& x, const dvar_vector& mu, const dvar_vector& std)
{
  #ifdef M_PI
  double pi = M_PI;
  #else
  double pi = 3.14159265358979323844;
  #endif
  int n = size_count(x);
  dvar_vector var = square(std);
  dvar_vector SS = square(x-mu);
  return 0.5*n*log(2.*pi) + sum(log(std)) + 0.5*sum(elem_div(SS,var));
}

/** Silly main function. This function is included just to see if it compiles with mygccs 
and should be removed for a real application.*/
int main(void)
{
  cout << "hello world" << endl;
}
