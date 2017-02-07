% fix kappa theta sigma

% read data from workspace
load 'C:\Users\jczhuo4\Desktop\Temp_Ruixin\FYP New Code\dATA.mat';
load 'C:\Users\jczhuo4\Desktop\Temp_Ruixin\FYP New Code\x6MLIBOR.mat';

swap2 = evalin('base','USSWAP2');
swap3 = evalin('base','USSWAP3');
swap5 = evalin('base','USSWAP5');
swap7 = evalin('base','USSWAP7');
swap10 = evalin('base','USSWAP10');

LIBOR = evalin('base','x6MLIBOR');
%theos = zeros(2618,1);
discount_curve_3 = zeros(2618,0);
discount_curve_4 = zeros(2618,0);
returns = zeros(2618,1);
% ---------------------------------------------
% Calibation process
% tool: 2-yr swap; target: 5-yr swap

[theos, dc_tool, dc_target,pars] = calibration(swap2,2,swap5,5);

% calculate error
error = theos - swap5;

% calculate the return
for i=1:1826 % maximum index for return
    if error(i) > 0.25
        % long target, short tool
        [target, tool]=calculate_return(swap2(i),discount_curve_3(i:22*6*2*3+i,1),2,...
                                    swap5(i), discount_curve_4(i:22*6*2*3+i,1),5,...
                                    LIBOR(i+6*22));
        X = hedge(swap5, par(i), 5, dc_target(i:22*6*2*3+i,1));
        Y = hedge(swap2, par(i), 2, dc_tool(i:22*6*2*3+i,1));
        delta = X/Y
        returns(i) = long - delta*short;

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