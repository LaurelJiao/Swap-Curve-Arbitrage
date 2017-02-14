function f = bondPrice(par,r_t,T) % parameters 1 2 3: kappa,theta,sigma
B = 1/par(1)*(1-exp(-par(1)*(T)));
A = exp((par(2)-par(3)^2/(2*par(1))^2)*(B-T)-par(3)^2/(4*par(1))*B^2);
f = A*exp(-B*r_t);
end
