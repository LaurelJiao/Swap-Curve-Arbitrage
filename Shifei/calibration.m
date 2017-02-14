function f = calibration(swap1,swap2,T1,T2)

result = zeros(2618,4);

% for i = 1:119
% 
% swapMonth1 = swap1(22*i-21:22*i,1);
% swapMonth2 = swap2(22*i-21:22*i,1);
% 
% % calculate short rate and parameters
% par = [0.4,0.05,0.25];
% r_t = calibrate_rt(par,swapMonth2,T2);
% par = calibrate_par(r_t,swapMonth1,T1);
% % r_t: 22-by-1; par: 1-by-3
% 
% % set an upper bound for sigma
% if par(3) > 1.25
%     par(3) = 0.7;
% end
%  
% % repeat using new parameters
% r_t = calibrate_rt(par,swapMonth2,T2);
% 
% 
% par = repmat(par,22,1);
% result(22*i-21:22*i,1:3)= par;
% result(22*i-21:22*i,4)= r_t;
% 
% % %version 2
% % for i = 1:119
% % 
% % swapMonth1 = swap1(22*i-21:22*i,1);
% % swapMonth2 = swap2(22*i-21:22*i,1);
% % 
% % % calculate short rate and parameters
% % par = [0.4,0.05,0.25];
% % r_t = calibrate_rt(par,swapMonth2,T2);
% % par = calibrate_par(r_t,swapMonth1,T1);
% % % r_t: 22-by-1; par: 1-by-3
% % 
% % % set an upper bound for sigma
% % if par(3) > 1.25
% %     par(3) = 0.7;
% % end
% %  
% % % repeat using new parameters
% % r_t = calibrate_rt(par,swapMonth2,T2);
% % 
% % 
% % par = repmat(par,22,1);
% % result(22*i-21:22*i,1:3)= par;
% % result(22*i-21:22*i,4)= r_t;


% version 1
swapMonth1 = swap1(1:2618,1);
swapMonth2 = swap2(1:2618,1);

% calculate short rate and parameters
par = [0.4,0.05,0.25];
r_t = calibrate_rt(par,swapMonth2,T2);
par = calibrate_par(r_t,swapMonth1,T1);
% r_t: 22-by-1; par: 1-by-3

% set an upper bound for sigma
if par(3) > 1.25
    par(3) = 0.7;
end
 
% repeat using new parameters
r_t = calibrate_rt(par,swapMonth2,T2);


par = repmat(par,2618,1);
result(1:2618,1:3)= par;
result(1:2618,4)= r_t;


f = result;
end

