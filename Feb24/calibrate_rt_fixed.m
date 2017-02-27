function f = calibrate_rt_fixed(parameters,swap1,swap2,T1,T2)
	x_data = [T1 T2];
	y_data = [swap1,swap2];
	y_t_init = -0.5.*randn(1,1)+0.5;
	fun = @(x_t)swapRate(parameters,x_t,y_t_init,x_data)-y_data;
 	options = optimset('Algorithm','levenberg-marquardt');
	x_t = fsolve(fun,0.02,options);

	fun = @(y_t)swapRate(parameters,x_t,y_t,x_data)-y_data;
	y_t = fsolve(fun,0.02,options);

	r_t = [x_t,y_t];
	f = r_t;

	end


