function [theos, dc_tool, dc_target, pars] = calibration(swap_tool,tool_maturity,swap_target,target_maturity)
pars = zeros(2618,3);
for i = 1:119
    % converting data to monthly
    par = [0.40,0.25,0.05];
    swap_tool_monthly = swap_tool(22*i-21:22*i,1);
    swap_target_monthly = swap_target(22*i-21:22*i,1);
    
    % calculate short rate and parameters
    r_t = calibrate_rt(par,swap_tool_monthly,tool_maturity);
    par = calibrate_par(r_t,swap_target_monthly,target_maturity);

    % set an upper bound for sigma
	if par(3) > 1.25
	    par(3) = 0.7;
	end

	% repeat using new par
	r_t = calibrate_rt(par,swap_tool_monthly,tool_maturity);
	theo_swapRate = swapRate(par,r_t,target_maturity);

	% calculate and store discount curve
	discountc_1 = bondPrice(par,r_t,tool_maturity);
	discountc_2 = bondPrice(par,r_t,target_maturity);
	dc_tool(22*i-21:22*i,1) = discountc_1;
	dc_target(22*i-21:22*i,1) = discountc_2;

	% calculate theoratical swap
	theos(22*i-21:22*i,1) = theo_swapRate;
	pars(22*i-21:22*i,:) = repmat(par,22,1);
end
end
