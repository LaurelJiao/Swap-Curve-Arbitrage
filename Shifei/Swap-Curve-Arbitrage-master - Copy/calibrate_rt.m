function f = calibrate_rt(par,swapMkt,T)
% tolerance number
small = 10^(-2);
len = length(swapMkt);
r_t = zeros();
for i = 1:len
    % interval for r_t
    interval = [-5,10];
    midpoint = (interval(1)+interval(2))/2;
    for j = 1:10
         if (swapMkt(i) - swapRate(par,midpoint,T)) < 0
                 interval = [interval(1),midpoint];
                 midpoint = (interval(1) + interval(2))/2;
         else if (swapMkt(i) - swapRate(par,midpoint,T)) > 0
                 interval = [midpoint,interval(2)];
                 midpoint = (interval(1) + interval(2))/2;
             else
                 r_t(i) = midpoint;
             end
         end
   end
    r_t(i) = midpoint;
end

f = r_t';
end
