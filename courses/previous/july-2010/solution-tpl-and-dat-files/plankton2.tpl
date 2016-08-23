DATA_SECTION
  init_int Nobs
  init_int alpha_phase
  init_ivector beta_phase(1,3) //Temperature, Depth, Salinity
  init_ivector Depth(1,Nobs)
  init_vector Y(1,Nobs)

  ivector tmp(1,Nobs)
  !!tmp=1;
  init_matrix Covar(1,Nobs,tmp,Depth)
  init_matrix Covar2(1,Nobs,tmp,Depth)

PARAMETER_SECTION
  init_number alpha(alpha_phase)
  init_number_vector beta(1,3,beta_phase)
  init_bounded_number sd(0.001,10)

  vector Ypred(1,Nobs)
  vector like(1,Nobs)

  objective_function_value f

PROCEDURE_SECTION
  Ypred.initialize();
  for(int i=1;i<=Nobs;i++)
  {
	for(int j=1;j<=Depth(i);j++)
	{
		Ypred(i)+=alpha+beta(1)*Covar(i,j)+beta(2)*j+beta(3)*Covar2(i,j);
	}
	like(i)=log(sd)+0.5*square((Y(i)-Ypred(i))/sd);
  }
  f=sum(like);

REPORT_SECTION
  report.precision(10);
  report<<"alpha "<<alpha<<endl;
  report<<"beta "<<beta<<endl;
  report<<"sd "<<sd<<endl;
  report<<"Y Ypred like"<<endl;
  for(int i=1;i<=Nobs;i++) report<<Y(i)<<" "<<Ypred(i)<<" "<<like(i)<<endl;


