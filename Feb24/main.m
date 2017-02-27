load 'C:\Users\jczhuo4\Desktop\Temp_Ruixin\Feb24\dATA.mat';
load 'C:\Users\jczhuo4\Desktop\Temp_Ruixin\Feb24\x6MLIBOR.mat';

% read data from workspace
swap2 = evalin('base','USSWAP2')/100;
swap3 = evalin('base','USSWAP3')/100;
swap5 = evalin('base','USSWAP5')/100;
swap7 = evalin('base','USSWAP7')/100;
swap10 = evalin('base','USSWAP10')/100;
LIBOR = evalin('base','x6MLIBOR')/100;

% initialize parameters
parameters = repmat([0.4,0.05,0.25,0.4,0.05,0.25],2618,1);
% calibrate rt
r_t = zeros(2618,2);

for i = 1:2618
    r_t(i,:) = calibrate_rt_fixed(parameters(i,:),swap2(i),swap10(i),2,10);
end
% r_t = calibrate_rt(parameters,swap2,swap10,2,10);

for i = 1:119
% calibrate parameters
marketSwap = [swap3((i*22-21):(i*22),1);swap5((i*22-21):(i*22),1);swap7((i*22-21):(i*22),1)];
maturity = [repmat(3,22,1);repmat(5,22,1);repmat(7,22,1)];
monthly_rt = repmat(r_t((i*22-21):(i*22),:),3,1);
% pause;
parameters((i*22-21):(i*22),:) = repmat(calibrate_parameters(monthly_rt,marketSwap,maturity),22,1);
end

% repeat the process with new parameters
% calibrate rt
r_t = zeros(2618,2);
for i = 1:2618
    r_t(i,:) = calibrate_rt(parameters(i,:),swap2(i),swap10(i),2,10);
end

% find theoretical 3 year swap and error
theo_swap = zeros(2618,1);
error = zeros(2618,1);
for i = 1:2618
    theo_swap(i,1) = swapRate(parameters,r_t(i,:),3);
    error(i,1) = theo_swap(i,1) - swap3(i);
end

% calculate payoff
payoff = calculate_payoff(error,LIBOR,swap3,3,swap2,swap10,parameters,r_t);

% set leverage
leverage = 6;
% calculate return
excess_returns = payoff*100/leverage;

% statistics
mr = mean(excess_returns);
vr = var(excess_returns);
str = std(excess_returns);
sk = skewness(excess_returns);
kur = kurtosis(excess_returns);
A = struct('mean',mr,'variance',vr,'stdev',str,'skewness',sk,'kurtosis',kur,'sharpe_ratio',mr/str)
% A = [mr vr str sk kur mr/str] ;
 
% plot
figure
plot(theo_swap,'b');
hold on
plot(swap3,'--r');
legend('Theoratical 3 year swap','Market 3 year swap');
set(legend,'FontSize',10);
hold off
 
figure
plot(error,'r');
hold on
plot(excess_returns,'--k');
legend('Deviation','Excesss Return');
set(legend,'FontSize',10);
hold off

