% Encoding using built in MATLAB-functions for Viterbi 


function code = encode2(bits)
% trellis = poly2trellis(5,[23 11]);
trellis = poly2trellis(3, [5 7]);
code = convenc(bits,trellis);

end