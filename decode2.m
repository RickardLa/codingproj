% Decoding using built in MATLAB-functions for Viterbi


function decodedBits = decode2(bits,flag,tblen)
% trellis = poly2trellis(5, [23 11]);
trellis = poly2trellis(3, [5 7]);


switch flag
    case 'Hard'
        % Constraint length = number of memory units
        decodedBits = vitdec(bits,trellis,tblen,'trunc',flag);
        
    case 'Soft'
%         decodedBits = vitdec(bits,trellis,tblen,'cont','soft', 100);
          
        decodedBits = vitdec(bits,trellis,tblen,'trunc','unquant');
%         bHat = vitdec(LLRs,trellis,K,'trunc','unquant');
end
end

