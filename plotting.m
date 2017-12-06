% plotting
clc
clf
clear all
close all

ber = [0.0749700000000000 0.0501600000000000 0.0302600000000000 0.0209800000000000 0.0108900000000000 0.00638000000000000 0.00295000000000000 0.00127000000000000 0.000640000000000000 0.000208000000000000 9.09090909090909e-05 3.21875000000000e-05 7.50000000000000e-06 2.60000000000000e-06 2.00000000000000e-07 2.00000000000000e-07 0 0 0 0 0 0 0 0 0 0 0];

load BER;
theoryBER = 0.5*erfc(sqrt(10.^(EbN0/10)));
semilogy(EbN0,theoryBER,'blue')
hold on 
semilogy(EbN0,ber,'ro-')
hold on

load BERuncoded
semilogy(EbN0,BER,'blueo')
legend 'Uncoded (theory)'  'Coded (simulation)' 'Uncoded (simulation)';
title('BER vs. E_{b}/N_{0} for QPSK')
xlabel('E_{b}/N_{0} [dB]')
ylabel('BER')
axis([-1 10 10^-6 1])