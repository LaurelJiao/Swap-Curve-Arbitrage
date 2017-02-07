% fix kappa theta sigma
par = [0.40,0.25,0.05];
% read data from workspace
yr2 = evalin('base','yr2');
r_t = calibrate_rt(par,yr2,2);
yr3 = evalin('base','yr3');
par = calibrate_par(r_t,yr3,3);

% repeat using new par
r_t = calibrate_rt(par,yr2,2);
theo_swapRate = swapRate(par,r_t,3);
plot(theo_swapRate,'b');
hold on
plot(yr3,'r');
