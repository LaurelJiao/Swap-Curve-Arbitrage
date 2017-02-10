function f = profitnloss(tool_swap, tool_maturity, dc_tool,target_swap, target_maturity, dc_target,error,LIBOR, pars)
	for i=1:1826
		[long short] = calculate_return(tool_swap(i),dc_tool(i:22*6*2*3+i,1),tool_maturity,target_swap(i),dc_target(i:22*6*2*3+i,1),target_maturity,LIBOR(i+6*22));
	% Calculate delta
		sum = 0;
		for j = 1:2*tool_maturity
			B = 1/pars(6*j*22+i-1,1)*(1-exp(-pars(6*j*22+i-1,1)*(tool_maturity)));
        	sum = sum - B*dc_tool(6*j*22+i-1);
    	end 
    	X = target_swap(i)/2 * sum- 1/pars(i,1)*(1-exp(-pars(i,1)*(target_maturity)))*dc_target(i);
    	Y = tool_swap(i)/2 * sum - 1/pars(i,1)*(1-exp(-pars(i,1)*(tool_maturity)))*dc_tool(i);
    	delta = X/Y;
		if error(i) > 0.25
			% long tool swap, short target swap
			% only the tool swap would invovle the hedge ratio
    		f(i) = delta*long - short;
    	else if error(i) < -0.25
    		% long target swap, short tool swap
    		f(i) = long - delta*short;
    	else f(i) = 0;
    	end
    end

	end

end
