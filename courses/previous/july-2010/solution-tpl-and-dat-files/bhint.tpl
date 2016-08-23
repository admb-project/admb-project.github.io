DATA_SECTION
  init_int nR
  init_int nC
  init_matrix obs(1,nR,1,nC)
  vector ssb(1,nR)
  !! ssb=column(obs,1);
  vector logR(1,nR)
  !! logR=column(obs,2);

  !! ad_comm::change_datafile_name("bh0.dat");
  init_int nR0
  init_int nC0
  init_matrix obs0(1,nR0,1,nC0)
  vector ssb0(1,nR0)
  !! ssb0=column(obs0,1);
  vector logR0(1,nR0)
  !! logR0=column(obs0,2);
  
PARAMETER_SECTION
  init_number loga;
  init_number logb;
  init_number logSigma;
  sdreport_number sigmaSq;
  vector pred(1,nR);

  init_number logSigma0;
  sdreport_number sigmaSq0;
  vector pred0(1,nR0);
  objective_function_value nll;
PROCEDURE_SECTION
  sigmaSq=exp(2.0*logSigma);
  pred=loga+log(ssb)-log(1+exp(logb)*ssb);
  nll=0.5*(nR*log(2*M_PI*sigmaSq)+sum(square(logR-pred))/sigmaSq);

  sigmaSq0=exp(2.0*logSigma0);
  pred0=loga+log(ssb0)-log(1+exp(logb)*ssb0);
  nll+=0.5*(nR0*log(2*M_PI*sigmaSq0)+sum(square(logR0-pred0))/sigmaSq0);

