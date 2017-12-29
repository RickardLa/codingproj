%% Exercise 1  - Encoder 2 and QPSK 
clc
clf
clear all

EbN0 = -1:0.5:10;  
trellis = poly2trellis(5,[23 11]);

spect = distspec(trellis,5);
berub = bercoding(EbN0,'conv','soft',1/2,spect); % BER bound


theoryBER = 0.5*erfc(sqrt(10.^(EbN0/10)));      % Theoretical uncoded
load UNCODED.mat
semilogy(EbN0,BER(1:23),'go')
hold on
semilogy(EbN0,theoryBER,'g')
hold on 
load SOFT.mat;                                  % Soft-decoding
semilogy(EbN0,BER,'ro-')
hold on
load HARD.mat;                                  % Hard-decoding
semilogy(EbN0,BER,'blueo-')
hold on
semilogy(EbN0,berub,'black')




legend 'Uncoded (simulation)' 'Uncoded (theory)'  'Soft-decoding (simulation)' 'Hard-decoding (simulation)' 'Upper bound for soft-decoding';
title('BER vs. E_{b}/N_{0} for QPSK')
xlabel('E_{b}/N_{0} [dB]')
ylabel('BER')
axis([-1 10 10^-5 1])
grid on