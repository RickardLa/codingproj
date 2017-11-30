function symbols = bi2sy(bits,flag)

switch flag
    case 'BPSK'

    case 'QPSK'
        const = [(1 + 1i) (1 - 1i) (-1 + 1i) (-1 - 1i)]/sqrt(2);
        msg = buffer(bits,length(bits)/2);
        msgIdx = bi2de(msg, 'left-msb')+1;
        symbols = const(msgIdx); 
    case 'AMPM'


end



end
