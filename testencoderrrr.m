%%
clc
clf
clear all
close all

 N = 100;
 bits = randi([0 1],N,1)';
% bits1 = [1 1 1 1 0 0 0 0];




state1 = 0;
state2 = 0;
c1 = zeros(1,length(bits));
c2 = zeros(1,length(bits));

for i=1:length(bits)
    c1(i) = mod(bits(i) + state2,2);
    c2(i) = mod(bits(i) + state1 + state2,2);
    state2 = state1;
    state1 = bits(i);


end


code=[c1; c2];
code=code(:)';




trellis = poly2trellis(3, [5 7]);
code1 = convenc(bits,trellis);

errors = sum(code1 ~= code)

