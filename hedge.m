function f = hedge(swap, par, T, dc_curve)
	
	sum = 0;
	for i = 1:2*T
		B = 1/par(1)*(1-exp(-par(1)*(i)));
        sum = sum - B*dc_curve(22*6+i-1);
    end 

    f = swap/2 * sum - 1/par(1)*(1-exp(-par(1)*(i)))*dc_curve(1)

end