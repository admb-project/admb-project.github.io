---
layout: default
title: ADMB Tips
---

ADMB Tips
---------
1. In the PARAMETER_SECTION (and perhaps elsewhere) when LOC_CALCS is used it must be preceded by a single space,

furthermore, all text within the LOC_CALCS - END_CALCS section must be indented by at least two spaces. If this

is not followed then an error results stating "Error in line 72 while reading d" if for example the line after

LOC_CALCS starts with the letter "d".

2. For a parameter vector to have individual components with different upper and lower bounds and with estimation of some parameters in different phases, need to declare an init_bounded_number_vector and not an init_bounded_vector. All parameters in the latter must have the same lower, upper bounds and phase.

3. Using a <tab> to start any line is a recipe for complete and utter disaster. It should always be a number of spaces and not a tab.

4. When there are problems such as "unable to convert prevariable to dvariable", try: value(X), which returns a double.

5. The block comment /* */ cannot be on the first space of any line.

6. fact(x) is not implemented but is equal to exp(gammln(x+1))

7. When declaring matrices and vectors it is not permissable to have any spaces in the declaration, thus

vector FinalEscapement(1,NGROUPS + 1); //results in an error vector FinalEscapement(1,NGROUPS+1); //does not result in an error

8. It is possible to input a label as a string using init_adstring label in the data file. There is, however, no way of inputting a vector of labels such as init_vector_adstring. A work around is possible using the following commands:

in GLOBAL_SECTION

adstring_array ParmLabel; // extendable vector to hold the parameter labels created below.

in DATA_SECTION reads parameter label prefixes from a file and generates some integer to strings

LOCAL_CALCS

ifstream ifs("ParmLabel.ss2");

adstring_array NumLbl;

adstring onenum(4);

adstring_array MGParmLbl; // parameter label prefixes

adstring_array GenderLbl; // gender label

for (i=1;i<=2;i++)
{

line_adstring sAD; // defines a line of input, including any special characters

ifs >> sAD; // reads the line from input stream

GenderLbl+=sAD; // appends the line to array, thus extending the vector by one addressable element

}

for (i=1;i<=20;i++)
{

_itoa( i, onenum, 10 );

NumLbl+=onenum;

line_adstring sAD;

ifs >> sAD;

MGParmLbl+=sAD;

}

END_CALCS

later in DATA_SECTION as parameters are pre-processed, customized labels are created, such as:

ParCount++; ParmLabel+=MGParmLbl(20)+"_move_in_seas_"+NumLbl(s)+"_from_"+NumLbl(p)+"_to_"+NumLbl(p2);
 
9. In the REPORT_SECTION nothing is allowed in the first column of characters, all lines must be indented by at least one space.
 
10. To output the maximum gradient component, cout or report1<< "objective_function_value::pobjfun->gmax"

If this is small (usually 1e-3 or less) then convergence is

likely, if large (>1) then convergence is unlikely.
 
11. The function sfabs implements a smooth absolute value.
