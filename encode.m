function code = encode(bits,flag)

state1 = 0;
state2 = 0;
c1 = zeros(1,length(bits));
c2 = zeros(1,length(bits));

switch flag
    case 0              % Uncoded
        code = bits;
    case 1              % G(D) = [1+D^2 1+D+D^2]
        for i=1:length(bits)
            c1(i) = mod(bits(i) + state2,2);
            c2(i) = mod(bits(i) + state1 + state2,2);
            state2 = state1;
            state1 = bits(i);
        end
    case 2
        
        
    case 3
        
        
    case 4
        
          
end


code=[c1; c2];
code=code(:)';


end
