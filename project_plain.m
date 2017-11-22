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
maxNumErrs = 100;       % get at least 100 bit errors (more is better)
maxNum = 1e7;           % OR stop if maxNum bits have been simulated
EbN0 = -1:0.5:12;       % power efficiency range

EsN0 = EbN0 + 10*log10(2);
SNRlin = 10.^(EsN0/10);
constQPSK = [(1 + 1i) (1 - 1i) (-1 + 1i) (-1 - 1i)]/sqrt(2);


% ======================================================================= %
% Simulation Chain
% ======================================================================= %
BER = zeros(1, length(EbN0)); % pre-allocate a vector for BER results

for i = 1:length(EbN0) % use parfor ('help parfor') to parallelize  
  totErr = 0;  % Number of errors observed
  num = 0; % Number of bits processed

  while((totErr < maxNumErrs) && (num < maxNum))
      % [SRC] generate N information bits 
      bits = randi([0 1],N,1);

      % [MOD] symbol mapper
      msg = buffer(bits,N/2);
      msgIdx = bi2de(msg, 'left-msb')+1;
      symb = constQPSK(msgIdx); 

      % [CHA] add Gaussian noise
      sigma = 1/(sqrt(2*SNRlin(i)));
      noise = sigma*(randn(1,N/2) + 1i*randn(1,N/2));
      noiseSymb = symb + noise;

      % [HR] Hard Receiver
      noiseSymb(real(noiseSymb)>0 & imag(noiseSymb)>0) = 1;
      noiseSymb(real(noiseSymb)>0 & imag(noiseSymb)<0) = 2;
      noiseSymb(real(noiseSymb)<0 & imag(noiseSymb)>0) = 3;
      noiseSymb(real(noiseSymb)<0 & imag(noiseSymb)<0) = 4;

      recSymb = constQPSK(noiseSymb); 
      recBits = de2bi(noiseSymb-1,2, 'left-msb');
      recBits = [recBits(:,1); recBits(:,2)];

      BitErrs = sum(bits ~= recBits); 
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
legend('Simulation', 'Theory')
title('BER vs. E_{b}/N_{0} for uncoded QPSK')
xlabel('E_{b}/N_{0} [dB]')
ylabel('BER')
axis([-1 10 10^-5 1])
% ======================================================================= %
% End
% ======================================================================= %