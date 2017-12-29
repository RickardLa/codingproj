% ======================================================================= %
% SSY125 Project
% ======================================================================= %
profile on
clc
clear

% ======================================================================= %
% Simulation Options
% ======================================================================= %
N = 1e5;                % simulate N bits each transmission (one block)
maxNumErrs = 500;       % get at least 100 bit errors (more is better)
maxNum = 1e7;           % OR stop if maxNum bits have been simulatedEncoders

Rc = 1/2;
EbN0 = -1:0.5:10;               % power efficiency range
EsN0 = EbN0 + 10*log10(Rc*2);   % Code-rate multiplied by bits per symbol to get correct EbN0
SNRlin = 10.^(EsN0/10);


decision = 'Hard';                  % Pick which receiver type to use. Hard or soft.
M = 4;                              % Modulation order

% Encoders
% trellis = poly2trellis(3,[5 7]);    % 1
trellis = poly2trellis(5,[23 11]);    % 2




tblen = 25;                         % Rule of thumb: traceback length is 5 times the constraint length


% ======================================================================= %
% Simulation Chain
% ======================================================================= %
BER = zeros(1, length(EbN0)); % pre-allocate a vector for BER results

for i = 1:length(EbN0) % use parfor ('help parfor') to parallelize
    totErr = 0;  % Number of errors observed
    num = 0; % Number of bits processed
    
    while((totErr < maxNumErrs) && (num < maxNum))
        bits = randi([0 1],N,1);
        code = convenc(bits,trellis);
        
        symb = qammod(code,M,'gray','InputType','bit','UnitAveragePower',1);
        noiseSymb = awgn(symb,EsN0(i),'measured');
        
        if strcmp('Soft',decision) == 1
            LLRs = qamdemod(noiseSymb,M,'UnitAveragePower',1,'OutputType','approxllr', 'NoiseVariance',10^(EsN0(i)/10));
            decodedBits = vitdec(LLRs,trellis,tblen,'trunc','unquant');
        else
            receivedBits = qamdemod(noiseSymb,M,'OutputType','bit');
            decodedBits = vitdec(receivedBits,trellis,tblen,'trunc','hard');
        end
        
        
        % Calculate errors
        BitErrs = sum(bits ~= decodedBits);
        
        totErr = totErr + BitErrs;
        num = num + N;
        
        %       disp(['+++ ' num2str(totErr) '/' num2str(maxNumErrs) ' errors. '...
        %           num2str(num) '/' num2str(maxNum) ' bits. Projected error rate = '...
        %           num2str(totErr/num, '%10.1e') '. +++']);
    end
    
    BER(i) = totErr/num;
    
end

semilogy(EbN0,BER,'or')
hold on
theoryBER = 0.5*erfc(sqrt(10.^(EbN0/10)));
semilogy(EbN0,theoryBER,'b')
axis([-1 10 10^-5 1])
grid on
% ======================================================================= %
% End
% ======================================================================= %