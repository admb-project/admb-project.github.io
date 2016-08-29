// Updated example from Steve Martell: Creating custom libraries for use in ADMB
// ADMB Foundation Newsletter 1(4):3-4, Oct 2009

#include <admodel.h>

dvariable dnorm(const double& x, const prevariable& mu, const prevariable& std)
{
  double pi = 3.14159265358979323844;
  return 0.5*log(2.*pi) + log(std) + 0.5*square((x-mu)/std);
}

dvariable dnorm(const dvector& x, const dvar_vector& mu, const dvar_vector& std)
{
  double pi = 3.14159265358979323844;
  int n = size_count(x);
  dvar_vector var = square(std);
  dvar_vector SS = square(x-mu);
  return 0.5*n*log(2.*pi) + sum(log(std)) + 0.5*sum(elem_div(SS,var));
}
