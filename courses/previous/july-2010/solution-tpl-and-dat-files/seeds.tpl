DATA_SECTION
  init_int N;
  init_vector r(1,N);
  init_vector n(1,N);
  init_vector x1(1,N);
  init_vector x2(1,N);

PARAMETER_SECTION
  init_number alpha0
  init_number alpha1
  init_number alpha2
  init_number alpha12
  init_number logSigma

  random_effects_vector B(1,N)
  
  sdreport_number sigma
  vector logitp(1,N)
  vector p(1,N)

  objective_function_value jnll

PROCEDURE_SECTION
  sigma=exp(logSigma);
  logitp=alpha0+alpha1*x1+alpha2*x2+alpha12*elem_prod(x1,x2)+B;
  p=elem_div(exp(logitp),(1.0+exp(logitp)));

  jnll=0.0;
  for(int i=1; i<=N; ++i){
    jnll += -log_comb(n(i),r(i))-log(p(i))*r(i)-log(1.0-p(i))*(n(i)-r(i));
    jnll += 0.5*(log(2.0*M_PI*square(sigma))+square(B(i)/sigma));
  }
