function f = bondPrice(par,x_t,y_t,T)
% "par" stands for parameters
% par 1 2 3 4 5 6: alpha, beta, sigma, mu, gamma, eta
% r_t 1 2: x_t, y_t
V = par(3)^2/par(2)^2*(T+2/par(2)*exp(-par(2)*T)-1/(2*par(2))*exp(-2*par(2)*T)-3/(2*par(2)))...
    + par(6)^2/par(5)^2*(T+2/par(5)*exp(-par(5)*T)-1/(2*par(5))*exp(-2*par(5)*T)-3/(2*par(5)));
f = exp(-(1-exp(-par(2)*T))/par(2)*x_t-(1-exp(-par(5)*T))/par(5)*y_t...
    + par(1)/par(2)*((1.-exp(-par(2)*T))/par(2)-T) + par(4)/par(5)*((1-exp(-par(5)*T))/par(5)-T)...
    + 1/2*V);
end
