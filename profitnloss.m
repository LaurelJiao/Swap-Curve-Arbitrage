function f = proftnloss(tool_swap, tool_maturity, dc_tool,target_swap, target_maturity, dc_target,error,LIBOR)
	for i=1:1826
		if error(i) > 0.25
			% long tool swap, short target swap
			% only the tool swap would invovle the hedge ratio
			[long short] = calculate_return(tool_swap,dc_tool,tool_maturity,target_swap,dc_target,target_maturity,LIBOR);
			% calculate hedge ratio delta
			sum = 0;
			for j = 1:2*tool_maturity
				B = 1/par(1)*(1-exp(-par(1)*(j)));
        		sum = sum + B*dc_tool(22*6+j-1);
    		end 

    		X = target_swap/2 * sum - 1/par(1)*(1-exp(-par(1)*(j)))*dc_curve(i);
	% 把算delta直接放到main里 能跑了再说

	end

end
