function f = calibrate_parameters(r_t,marketSwap,T)
par0 = [0.4,0.05,0.25,0.4,0.05,0.25];
fun = @(par)swapRate(par,r_t,T) - marketSwap;
f = lsqnonlin(fun,par0,[0,0,0,0,0,0],[]);


% par0 = [0.4,0.05,0.25,0.4,0.05,0.25];
% x_data = [r_t,T];
% y_data = marketSwap;
% fun = @(parameters,x_data)swapRate(parameters,x_data(:,1:2),x_data(:,3))-y_data;
% options = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective');
% parameters = lsqcurvefit(fun,par0,x_data,y_data,[],[],options);
% f = parameters;
end
