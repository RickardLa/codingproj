function code = encode(bits)

state1 = 0;
state2 = 0;
c1 = zeros(1,length(bits));
c2 = zeros(1,length(bits));


for i=1:length(bits)
    c1(i) = mod(bits(i) + state2, 2);
    c2(i) = mod(bits(i) + state1 + state2, 2);
    state2 = state1;
    state1 = bits(i);
end


code=[c1; c2];
code=code(:)';


end
