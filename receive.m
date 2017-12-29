function recBits = receive(noiseSymb,flag,SNRlin)

switch flag
    case 'Hard'
          noiseSymb(real(noiseSymb)>0 & imag(noiseSymb)>0) = 1;
          noiseSymb(real(noiseSymb)>0 & imag(noiseSymb)<0) = 2;
          noiseSymb(real(noiseSymb)<0 & imag(noiseSymb)>0) = 3;
          noiseSymb(real(noiseSymb)<0 & imag(noiseSymb)<0) = 4;
          
          recBits = de2bi(noiseSymb-1,2, 'left-msb');
          recBits = [recBits(:,1); recBits(:,2)];
    case 'Soft'
        
%           recBits = qamdemod(noiseSymb',4,'UnitAveragePower',1,'OutputType','approxllr', ...
%             'NoiseVariance',SNRlin);
        recBits = qamdemod(noiseSymb',4,'UnitAveragePower',1,'OutputType','approxllr', 'NoiseVariance',SNRlin);
        
          
    
end




end
