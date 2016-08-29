//======================================================================================================================
// File:        pella2.tpl
// Model:       Pella-Tomlinson model, with Binit=k*a
// Parameters:  r, k, a, p, q, sigma
// Fitted data: Abundance index
// Likelihood:  Log-transformed normal
// References:  Polacheck et al. (1993)
// Notes:       q and sigma are free parameters, to allow full uncertainty in MCMC analysis
// History:     18 Jan 2014 Arni Magnusson updated interface: *.ctl now specifies LUP and *.pin specifies initial values
//               6 Jan 2011 Arni Magnusson improved vector extraction
//               7 Oct 2010 Arni Magnusson improved string handling and comments
//               9 Mar 2010 Arni Magnusson created, to benchmark against R optimizers
//======================================================================================================================
// Implementation notes
//   Abundance index may not exist for all years
//   Vectors that include all years: B, C
//   Vectors that include abundance index years: I, Ifit, X
//   X links long and short vectors
//======================================================================================================================

GLOBALS_SECTION
  #include "admodel.h"
  #include <string>
  using std::string;
  const double pi = 3.141592654;
  int mcmc_iteration = 0;
  ofstream mcmc_par("mcmc_par.csv");
  ofstream mcmc_bio("mcmc_bio.csv");

DATA_SECTION
  // Read data file
  init_int nc
  init_matrix Cdata(1,nc,1,2)  // Year | C
  init_int ni
  init_matrix Idata(1,ni,1,2)  // Year | I
  // Vectors
  ivector Cyear(1,nc)
  ivector Iyear(1,ni)
  vector C(1,nc)
  vector I(1,ni)
  ivector X(1,ni)  // years with abundance index: 1995 | 1998 | ...
  // Constants
  number halfnlog2pi
  vector logI(1,ni)
  // Switch to control file
  !! string run_name = string(adprogram_name);
  !! if(option_match(argc,argv,"-ind") > -1)
  !! {
  !!   run_name = argv[option_match(argc,argv,"-ind") + 1];
  !!   run_name = run_name.substr(0, run_name.rfind("."));
  !! }
  !! change_datafile_name((adstring)run_name.c_str() + ".ctl");
  // Read control file (phase, lower, upper, init)
  init_vector logr_lup(1,3)
  init_vector logk_lup(1,3)
  init_vector loga_lup(1,3)
  init_vector logp_lup(1,3)
  init_vector logq_lup(1,3)
  init_vector logsigma_lup(1,3)

PARAMETER_SECTION
  // Estimated
  init_bounded_number logr(logr_lup)
  init_bounded_number logk(logk_lup)
  init_bounded_number loga(loga_lup)
  init_bounded_number logp(logp_lup)
  init_bounded_number logq(logq_lup)
  init_bounded_number logsigma(logsigma_lup)
  // Derived
  number r
  number k
  number a
  number p
  sdreport_number q
  number sigma
  // Updated
  vector B(1,nc)
  vector Bfit(1,ni)
  vector Ifit(1,ni)
  number RSS
  // Report
  matrix summary(1,nc,1,5)  // Year | B | C | I | Ifit
  // Objfun
  objective_function_value neglogL

PRELIMINARY_CALCS_SECTION
  // Data
  Cyear = (ivector) column(Cdata,1);
  C = column(Cdata,2);
  Iyear = (ivector) column(Idata,1);
  I = column(Idata,2);
  X = Iyear - Cyear(1) + 1;
  halfnlog2pi = 0.5*ni*log(2*pi);
  logI = log(I);

PROCEDURE_SECTION
  get_fit();
  get_neglogL();
  if(mceval_phase())
    write_mcmc();

REPORT_SECTION
  summary.initialize();
  get_summary();
  report<<setprecision(12)
        <<"# r"      <<endl<<r      <<endl
        <<"# k"      <<endl<<k      <<endl
        <<"# a"      <<endl<<a      <<endl
        <<"# p"      <<endl<<p      <<endl
        <<"# q"      <<endl<<q      <<endl
        <<"# sigma"  <<endl<<sigma  <<endl
        <<"# RSS"    <<endl<<RSS    <<endl
        <<"# neglogL"<<endl<<neglogL<<endl<<endl;
  report<<setprecision(4)
        <<"# Model summary"<<endl
        <<" Year Biomass Catch Index IndexFit"<<endl
        <<summary<<endl;

FUNCTION get_fit
  r = mfexp(logr);
  k = mfexp(logk);
  a = mfexp(loga);
  p = mfexp(logp);
  q = mfexp(logq);
  sigma = mfexp(logsigma);
  B(1) = k * a;
  for(int t=1; t<=nc-1; t++)
    B(t+1) = sfabs(B(t) + r/p*B(t)*(1-pow(B(t)/k,p)) - C(t));
  Ifit = q*B(X);

FUNCTION get_neglogL
  RSS = norm2(logI-log(Ifit));
  neglogL = halfnlog2pi + ni*log(sigma) + RSS/(2*sigma*sigma);

FUNCTION get_summary
  summary.colfill(1,(dvector)Cyear);
  summary.colfill(2,B);
  summary.colfill(3,C);
  for(int i=1; i<=ni; i++)  // allow missing years in abundance index
  {
    summary(X(i),4) = I(i);
    summary(X(i),5) = Ifit(i);
  }

FUNCTION write_mcmc
  mcmc_iteration++;
  // Parameters
  if(mcmc_iteration == 1)
    mcmc_par<<"neglogL,r,k,a,p,q,sigma"<<endl;
  mcmc_par<<neglogL<<","
          <<r      <<","
          <<k      <<","
          <<a      <<","
          <<p      <<","
          <<q      <<","
          <<sigma  <<endl;
  // Biomass
  if(mcmc_iteration == 1)
  {
    mcmc_bio<<Cyear(1);
    for(int t=2; t<=nc; t++)
      mcmc_bio<<","<<Cyear(t);
    mcmc_bio<<endl;
  }
  mcmc_bio<<B(1);
  for(int t=2; t<=nc; t++)
    mcmc_bio<<","<<B(t);
  mcmc_bio<<endl;
