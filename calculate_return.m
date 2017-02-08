function f = calculate_return(swap_long, curve_long, maturity_long,...
                              swap_short, curve_short, maturity_short,LIBOR)
                          
    % long fixed position
    sum = 0; 
    for i = 3:2*maturity_long
        sum = sum + curve_long(22*6+i-1);
    end
    long = swap_long/2*(LIBOR+1+sum)+curve_long(22*12,1)-1;
       
    % short fixed position
    sum = 0;
    for i = 3:2*maturity_short
        sum = sum+ curve_short(22*6+i-1);
    end
    short = -1*swap_short/2*(LIBOR+1+sum)-curve_short(22*12,1)+1;
        
    f = long+short;
end
