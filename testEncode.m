%%
clc
clf
clear all
close all

% N = 100;
% bits1 = randi([0 1],N,1)';
bits1 = [1 1 1 1 0 0 0 0];




InitialState = [0 0];
bits = [InitialState bits1];



c1 = zeros(1,length(bits1));
c2 = zeros(1,length(bits1));
for i=2:length(bits1)
     c1(i-1) = mod(bits(i) + bits(i+1),2);
     c2(i-1) = mod(bits(i-1) + bits(i) + bits(i+1),2);
     bits(i-1) = bits(i);
     bits(i)
    
end

 code=[c1; c2];
 code=code(:)';




trellis = poly2trellis(3, [5 7]);
code1 = convenc(bits1(1:end/2),trellis);

errors = sum(code1 ~= c1)


