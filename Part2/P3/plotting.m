%% Exercise - Three different systems 
clc
clf
clear all

EbN0 = -1:0.5:10;  


theoryBER = 0.5*erfc(sqrt(10.^(EbN0/10)));      

semilogy(EbN0,theoryBER,'g')                    % Theoretical uncoded
hold on 

% System 1: e3 and BPSK
load s1.mat;                                    
semilogy(EbN0,BER,'ro')
hold on

% % System 2: e3 and Gray-QPSK
load s2.mat;                                    
semilogy(EbN0,BER,'blueo')
hold on

% % System 3: e4 and AMPPM
% load e3.mat;                                    
% semilogy(EbN0,BER,'mo')




% leg1 = legend('Uncoded (theoretical)','$\epsilon_{1}$ (simulation)','$\epsilon_{2}$ (simulation)','$\epsilon_{3}$ (simulation)',...
%               'Upper bound $\epsilon_{1}$', 'Upper bound $\epsilon_{2}$', 'Upper bound $\epsilon_{3}$');

leg1 = legend('Uncoded (theoretical)', '$\epsilon_{3}$ with QPSK','$\epsilon_{3}$ with BPSK');
set(leg1,'Interpreter','latex');
set(leg1,'FontSize',12);


title('SER vs. E_{b}/N_{0}. Soft-receiver.')
xlabel('E_{b}/N_{0} [dB]')
ylabel('SER')
axis([-1 10 10^-5 1])
grid on