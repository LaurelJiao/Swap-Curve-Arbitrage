% fix kappa theta sigma

% read data from workspace
load 'C:\Users\rjiao3\Downloads\Swap-Curve-Arbitrage-master\Swap-Curve-Arbitrage-master\dATA.mat';
load 'C:\Users\rjiao3\Downloads\Swap-Curve-Arbitrage-master\Swap-Curve-Arbitrage-master\x6MLIBOR.mat';

swap2 = evalin('base','USSWAP2');
swap3 = evalin('base','USSWAP3');
swap5 = evalin('base','USSWAP5');
swap7 = evalin('base','USSWAP7');
swap10 = evalin('base','USSWAP10');

LIBOR = evalin('base','x6MLIBOR');
%theos = zeros(2618,1);
% discount_curve_3 = zeros(2618,0);
% discount_curve_4 = zeros(2618,0);
returns = zeros(2618,1);

% ----------------------------------------------------------
% Calibation process
% tool: 2-yr swap; target: 5-yr swap

[theos, dc_swap2, dc_swap5, pars,rts] = calibration(swap2,2,swap5,5);

% calculate error
error = theos - swap5;

% calculate the profit n loss
% target yr5, tool yr2
returns = profitnloss(swap2, 2, dc_swap2,swap5, 5, dc_swap5,error,LIBOR,pars,rts);

stat = zeros(5,1);
stat(1) = mean(returns);
stat(2) = var(returns);
stat(3) = std(returns);
stat(4) = skewness(returns);
stat(5) = kurtosis(returns);

 
figure
plot(theos,'b');
hold on
plot(swap5,'--r');
legend('Theoratical 5 year swap','Market 5 year swap');
set(legend,'FontSize',24);
hold off

figure
plot(error,'r');
hold on
plot(returns,'--k');
legend('Deviation','Return');
set(legend,'FontSize',24);
hold off
