function f = swapRate(par,r_t,T)
n = T/0.5;
sum = 0;
for i=1:n
    sum = sum + bondPrice(par,r_t,i*0.5);
end
f = 2*(1-bondPrice(par,r_t,T))./sum;
end
