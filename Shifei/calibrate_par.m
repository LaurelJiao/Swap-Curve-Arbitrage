function f = calibrate_par(r_t,swapMkt,T)
par0 = [0.4,0.05,0.25];
fun = @(par)swapRate(par,r_t,T) - swapMkt;
f = lsqnonlin(fun,par0,[0,0,0],[]);
end
