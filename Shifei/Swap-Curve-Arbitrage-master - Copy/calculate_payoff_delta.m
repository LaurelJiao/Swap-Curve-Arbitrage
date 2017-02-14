function f = calculate_payoff_delta(tool_swap, tool_maturity,target_swap, target_maturity,...
                                    error,LIBOR, pars, rts)
    trans = 0.0025; % 0.25 bsp, as in percentage
	for i=1:2353
        % calculate delta
		sum = 0;
		for j = 1:2*tool_maturity
			B = 1/pars(i,1)*(1-exp(-pars(i,1)*(0.5*j)));
        	sum = sum - B*bondPrice(pars(i,:),rts(i),0.5*j);
    	end 
    	X = target_swap(i)/2 * sum- 1/pars(i,1)*(1-exp(-pars(i,1)*(target_maturity)))*bondPrice(pars(i,:),rts(i),target_maturity);
    	Y = tool_swap(i)/2 * sum- 1/pars(i,1)*(1-exp(-pars(i,1)*(tool_maturity)))*bondPrice(pars(i,:),rts(i),tool_maturity);
    	delta = X/Y;
		if error(i) > 0.25
			% long tool swap, short target swap
			% only the tool swap would invovle the hedge ratio
            short = -0.5*(target_swap(i)+trans)* (1+0.5*LIBOR(i)) -0.5*(target_swap(i)+trans) + swapValue(target_swap(i),rts(i+22*12),pars(i+22*12,:),target_maturity,1);
            long = 0.5*(tool_swap(i)-trans)* (1+0.5*LIBOR(i)) +0.5*(tool_swap(i)-trans) - swapValue(tool_swap(i),rts(i+22*12),pars(i+22*12,:),tool_maturity,1);
            f(i) = delta*long + short;
    	else if error(i) < -0.25
    		% long target swap, short tool swap
            short = -0.5*tool_swap(i)* (1+0.5*LIBOR(i)) -0.5*tool_swap(i) + swapValue(tool_swap(i),rts(i+22*12),pars(i+22*12,:),tool_maturity,1);
            long = 0.5*target_swap(i)* (1+0.5*LIBOR(i)) +0.5*target_swap(i) - swapValue(target_swap(i),rts(i+22*12),pars(i+22*12,:),target_maturity,1);
    		f(i) = long + delta*short;
    	else f(i) = 0;
    	end
    end

	end

end
