% Test the correctness of r_t in run time


for i=1:2618
	Swap_2(i,1) = swapRate(parameters(i,:),r_t(i,:),2);
	Swap_10(i,1) = swapRate(parameters(i,:),r_t(i,:),10);

end

for j=1:2618
	Swap_2(j,1) = swapRate(parameters(j,:),r_t(j,1),r_t(j,2),2);
	Swap_10(j,1) = swapRate(parameters(j,:),r_t(j,1),r_t(j,2),10);

end

figure
plot(swap2 - Swap_2,'--k');
hold on
plot(Swap_2,'r');

figure
plot(swap10 - Swap_10,'b');
hold on
plot(Swap_10,'r');