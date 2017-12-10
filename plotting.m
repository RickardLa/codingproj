% plotting
clc
clf
clear all
close all

% ber1 is the result from the simulated coded transmission 
ber1 = [0.268500000000000 0.225150000000000 0.197660000000000 0.165610000000000 0.133450000000000 0.100750000000000 0.0707700000000000 0.0491800000000000 0.0320700000000000 0.0211900000000000 0.0119900000000000 0.00622000000000000 0.00292000000000000 0.00138000000000000 0.000640000000000000 0.000333333333333333 8.58333333333333e-05 4.00000000000000e-05 9.70000000000000e-06 2.20000000000000e-06 7.00000000000000e-07 2.00000000000000e-07 0 0 0 0 0];
load BERuncoded.mat     % Loading uncoded transmission and all variables needed


theoryBER = 0.5*erfc(sqrt(10.^(EbN0/10)));
semilogy(EbN0,theoryBER,'blue')
hold on 
semilogy(EbN0,ber1,'ro-')
hold on


semilogy(EbN0,BER,'blueo')
legend 'Uncoded (theory)'  'Coded (simulation)' 'Uncoded (simulation)';
title('BER vs. E_{b}/N_{0} for QPSK')
xlabel('E_{b}/N_{0} [dB]')
ylabel('BER')
axis([-1 10 10^-5 1])
grid on
