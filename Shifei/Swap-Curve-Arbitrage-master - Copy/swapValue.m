function f = swapValue(S,r_t,par,T,N)
n = T/0.5;
sum = 0;
for i=1:n
    sum = sum + bondPrice(par,r_t,i*0.5);
end
f = (1-(bondPrice(par,r_t,T)+0.5*S*sum))*N;
end
