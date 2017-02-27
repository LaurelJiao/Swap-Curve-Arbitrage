function [delta1,delta2] = hedgeRatio(par,T,r_t,swap,swap2,swap10)
% par stands for "parameters"
% the sum terms in the formula
n = T/0.5;
sum = 0;
for i=1:n
    sum = sum + -(1-exp(-par(2)*i*0.5))/par(2)*bondPrice(par,r_t,i*0.5);
end
   
n = 2/0.5;
sum2 = 0;
for i=1:n
    sum2 = sum2 + -(1-exp(-par(2)*i*0.5))/par(2)*bondPrice(par,r_t,i*0.5);
end

n = 10/0.5;
sum10 = 0;
for i=1:n
    sum10 = sum10 + -(1-exp(-par(2)*i*0.5))/par(2)*bondPrice(par,r_t,i*0.5);
end

A = (-(1-exp(-par(2)*T))/par(2)*bondPrice(par,r_t,T) + swap/2*sum);
B = (-(1-exp(-par(2)*2))/par(2)*bondPrice(par,r_t,2) + swap2/2*sum2);
C = (-(1-exp(-par(2)*10))/par(2)*bondPrice(par,r_t,10) + swap10/2*sum10);
D = (-(1-exp(-par(5)*T))/par(5)*bondPrice(par,r_t,T) + swap/2*sum);
E = (-(1-exp(-par(5)*2))/par(5)*bondPrice(par,r_t,2) + swap2/2*sum2);
F = (-(1-exp(-par(5)*10))/par(5)*bondPrice(par,r_t,10) + swap10/2*sum10);

delta1 = (A*F-C*D)/(B*F-C*E);
delta2 = (A*E-B*D)/(C*E-B*F);
end
