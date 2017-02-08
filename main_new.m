% fix kappa theta sigma

% read data from workspace
load 'C:\Users\c2510w2\Desktop\FYP New Code\dATA.mat';
load 'C:\Users\c2510w2\Desktop\FYP New Code\x6MLIBOR.mat';
swap2 = evalin('base','USSWAP2');
swap3 = evalin('base','USSWAP3');
swap5 = evalin('base','USSWAP5');
swap7 = evalin('base','USSWAP7');
swap10 = evalin('base','USSWAP10');

LIBOR = evalin('base','x6MLIBOR');
theos = zeros(2618,1);
discount_curve_3 = zeros(2618,0);
discount_curve_4 = zeros(2618,0);
returns = zeros(2618,1);

% target yr 5
for i = 1:119
par = [0.40,0.25,0.05];
yr2 = swap2(22*i-21:22*i,1);
yr3 = swap3(22*i-21:22*i,1);
yr5 = swap5(22*i-21:22*i,1);
yr7 = swap7(22*i-21:22*i,1);
yr10 = swap10(22*i-21:22*i,1);

% calculate short rate and parameters
r_t = calibrate_rt(par,yr2,2);
par = calibrate_par(r_t,yr5,5);

% set an upper bound for sigma
if par(3) > 1.25
    par(3) = 0.7;
end

% repeat using new par
r_t = calibrate_rt(par,yr2,2);
theo_swapRate = swapRate(par,r_t,5);

% calculate and store discount curve
discountc_1 = bondPrice(par,r_t,2);
discountc_2 = bondPrice(par,r_t,5);
discount_curve_3(22*i-21:22*i,1) = discountc_1;
discount_curve_4(22*i-21:22*i,1) = discountc_2;

% calculate theoratical swap
theos(22*i-21:22*i,1) = theo_swapRate;
end
% calculate error
error = theos - swap5;

% calculate the return
for i=1:1826 % maximum index for return
    if error(i) > 0.25
        % long s5, short s7
        returns(i)=calculate_return(swap2(i),discount_curve_3(i:22*6*2*3+i,1),2,...
                                    swap5(i), discount_curve_4(i:22*6*2*3+i,1),5,...
                                    LIBOR(i+6*22));
    else if error(i) < -0.25
        returns(i)=calculate_return(swap5(i),discount_curve_4(i:22*6*2*3+i,1),5,...
                                    swap2(i), discount_curve_3(i:22*6*2*3+i,1),2,...
                                    LIBOR(i+6*22));
        else returns(i) =0;
        end
    end
end

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