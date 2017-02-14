function f = calculate_return(leverage,error,LIBOR,swap1,swap2,T1,T2,par,r_t)
payoffs = calculate_payoff(error,LIBOR,swap1,swap2,T1,T2,par,r_t);
excess_returns = payoffs*100/leverage;
f = excess_returns;
end

