function f = calibrate_rt(par,swapMkt,T)
 
len = length(swapMkt);
r_t = zeros(len,1);
for i = 1:len
    % interval for r_t
    
    interval = [-0.5,0.5];
    midpoint = (interval(1)+interval(2))/2;
     for j = 1:20
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
   
    r_t(i) = midpoint;
    end
end
 
f = r_t;
end
