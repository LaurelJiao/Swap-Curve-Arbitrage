function f = calculate_payoff(error,LIBOR,swap1,swap2,T1,T2,par,r_t)
payoffs = zeros(2353,1);
% calculate the return
for i=1:2353 % maximum index for return
    if error(i) > 0.25/100
        % long swap1, short swap2
        payoffs(i) =  ...
-0.5*swap1(i)* (1+0.5*LIBOR(i)) -0.5*swap1(i) + swapValue(swap1(i),r_t(i+22*12),par(i+22*12,:),T1,1) ...
+0.5*swap2(i)* (1+0.5*LIBOR(i)) +0.5*swap2(i) - swapValue(swap2(i),r_t(i+22*12),par(i+22*12,:),T2,1);

    else if error(i) < -0.25/100
        payoffs(i) =  ...
+0.5*swap1(i)* (1+0.5*LIBOR(i)) +0.5*swap1(i) -swapValue(swap1(i),r_t(i+22*12),par(i+22*12,:),T1,1) ...
-0.5*swap2(i)* (1+0.5*LIBOR(i)) -0.5*swap2(i) + swapValue(swap2(i),r_t(i+22*12),par(i+22*12,:),T2,1);
        else payoffs(i) =0;
        end
    end
    
end

f = payoffs;
end
