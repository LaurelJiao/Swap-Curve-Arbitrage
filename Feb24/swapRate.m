function f = swapRate(parameters,x_t,y_t,T)
n = T/0.5;
sum = 0;
for i=1:n
    sum = sum + bondPrice(parameters,x_t,y_t,i*0.5);
end
f = 2*(1-bondPrice(parameters,x_t,y_t,T))/sum;
end
