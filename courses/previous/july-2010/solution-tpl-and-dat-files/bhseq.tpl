DATA_SECTION
  init_int nR
  init_int nC
  init_matrix obs(1,nR,1,nC)
  vector ssb(1,nR)
  !! ssb=column(obs,1);
  vector logR(1,nR)
  !! logR=column(obs,2);
  
  init_vector priorMean(1,2)
  init_vector priorSd(1,2)
  init_matrix priorCor(1,2,1,2)
  matrix priorCov(1,2,1,2)
  !! priorCov=elem_prod(outer_prod(priorSd,priorSd),priorCor);

PARAMETER_SECTION
  init_number loga;
  init_number logb;
  init_number logSigma;
  sdreport_number sigmaSq;
  vector pred(1,nR);
  vector logab(1,2);
  vector diff(1,2);
  objective_function_value nll;
PROCEDURE_SECTION
  sigmaSq=exp(2.0*logSigma);
  pred=loga+log(ssb)-log(1+exp(logb)*ssb);
  nll=0.5*(nR*log(2*M_PI*sigmaSq)+sum(square(logR-pred))/sigmaSq);

  logab(1)=loga; logab(2)=logb;
  diff=logab-priorMean;
  nll+=0.5*(log(2.0*M_PI)*2.0+log(det(priorCov))+diff*inv(priorCov)*diff);
