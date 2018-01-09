clc
clear all


R = 1:23;
EbN0 = -1:0.5:10;  
c= 1/2*log10(1 +2*R.*(EbN0));
plot(c,R)
grid on