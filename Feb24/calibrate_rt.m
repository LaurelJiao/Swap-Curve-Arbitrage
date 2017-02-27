function f = calibrate_rt(parameters,swap1,swap2,T1,T2)
% x_data = (repmat([T1 T2],2618,1))';
% y_data = ([swap1,swap2])';
%---------------------------------------------------------------------
x_data = [T1 T2];
y_data = [swap1,swap2];
fun = @(r_t,x_data)swapRate(parameters,r_t,x_data);
r_t = lsqcurvefit(fun,[0.02,0.03],x_data,y_data);
%----------------------------------------------------------------------
% fsolve
% options = optimset('Algorithm','levenberg-marquardt');
% fun = @(r_t)swapRate(parameters,r_t,x_data)-y_data;
% % % r_t = fsolve(fun,repmat([0.02,0.03],2618,1));
% r_t = fsolve(fun, [0.02,0.03],options);
%------------------------------------------------------------------------

% fminuc
% options = optimoptions(@fminunc,'Algorithm','quasi-newton');
% fun = @(r_t)(swapRate(parameters, r_t,x_data)-y_data).^2;
% r_t = fminunc(fun,[0.02,0.03],options);
f = r_t;

% syms x y
% S = solve([swapRate(parameters,[x,y],T1)==swap1, swapRate(parameters,[x,y],T2)==swap2], [x,y]);
% S.x
% S.y
% f = [S.x,S.y];
end
