function f = calculate_return(leverage,error,LIBOR,tool_swap,tool_maturity,target_swap,target_maturity,pars,rts)
payoffs = calculate_payoff_delta(tool_swap, tool_maturity,target_swap, target_maturity,...
                                    error,LIBOR, pars, rts);
excess_returns = payoffs/leverage;
f = excess_returns;
end

