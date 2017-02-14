load 'D:\2016-2017 first semester\FYP_New_Folder\data\dATA.mat';
load 'D:\2016-2017 first semester\FYP_New_Folder\data\x6MLIBOR.mat';

% read data from workspace
swap2 = evalin('base','USSWAP2')/100;
swap3 = evalin('base','USSWAP3')/100;
swap5 = evalin('base','USSWAP5')/100;
swap7 = evalin('base','USSWAP7')/100;
swap10 = evalin('base','USSWAP10')/100;
LIBOR = evalin('base','x6MLIBOR')/100;

% calibrate yr2 using yr5
result = calibration(swap2,swap5,2,5);
par = result(:,1:3);
r_t = result(:,4);

% calculate theoretical yr2 swap
theo_swapRate = zeros(2618,1);
for i=1:2618
 theo_swapRate(i,1) = swapRate(par(i,:),r_t(i),2);
end
 
% calculate error
error = zeros(2618,1);
for i=1:2618
 error(i,1) = theo_swapRate(i,1)-swap2(i);
end

% set leverage
leverage = 6;

% calculate return
% returns = zeros(2353,1);
returns = calculate_return(leverage,error,LIBOR,swap2,swap5,1,4,par,r_t);

% statistics
mr = mean(returns);
vr = var(returns);
str = std(returns);
sk = skewness(returns);
kur = kurtosis(returns);
A = [mr vr str sk kur mr/str] ;
 
% plot
figure
plot(theo_swapRate,'b');
hold on
plot(swap2,'--r');
legend('Theoratical 3 year swap','Market 3 year swap');
set(legend,'FontSize',10);
hold off
 
figure
plot(error,'r');
hold on
plot(returns,'--k');
legend('Deviation','Return');
set(legend,'FontSize',10);
hold off

