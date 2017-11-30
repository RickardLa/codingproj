function recBits = receive(noiseSymb,flag)

switch flag
    case 'Hard'
          noiseSymb(real(noiseSymb)>0 & imag(noiseSymb)>0) = 1;
          noiseSymb(real(noiseSymb)>0 & imag(noiseSymb)<0) = 2;
          noiseSymb(real(noiseSymb)<0 & imag(noiseSymb)>0) = 3;
          noiseSymb(real(noiseSymb)<0 & imag(noiseSymb)<0) = 4;
    case 'Soft'
          % For later... 
    
end

recBits = de2bi(noiseSymb-1,2, 'left-msb');
recBits = [recBits(:,1); recBits(:,2)];

end
