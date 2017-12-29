clear;clc;

K = 1e5; % Number of data bits
M = 4; % Modulation order
varN = 0.1; % Noise variance
trellis = poly2trellis(3,[5 7]); % Trellis structure for encoder 1

b = randi([0 1],K,1); % Data bits
c = convenc(b,trellis); % Coded bits (without zero-termination)

s = qammod(c,M,'gray','InputType','bit','UnitAveragePower',1); % Symbols
n = sqrt(varN)*(randn(K,1)+1i*randn(K,1)); % AWGN
r = s+n; % Received samples

LLRs = qamdemod(r,4,'UnitAveragePower',1,'OutputType','approxllr', 'NoiseVariance',varN); % LLRs for r
bHat = vitdec(LLRs,trellis,K,'trunc','unquant'); % Detected data bits

sum(b~=bHat) % Number of bit errors