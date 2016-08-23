DATA_SECTION
  init_int Nobs
  init_vector y(1,Nobs)
PARAMETER_SECTION
  init_number mean
  init_number sd
  objective_function_value f
PROCEDURE_SECTION
  f=Nobs*log(sd) +0.5*sum(square((y-mean)/sd));

