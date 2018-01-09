%% Exercise 2  - Encoder 1,2,3. Gray QPSK. Only soft receiver. 
clc
clf
clear all

EbN0 = -1:0.5:10;  

trellis1 = poly2trellis(3,[5 7]);    % 1
trellis2 = poly2trellis(5,[23 11]);  % 2
trellis3 = poly2trellis(5,[23 33]);  % 3


spect1 = distspec(trellis1,3);
berub1 = bercoding(EbN0,'conv','soft',1/2,spect1); % BER bound
spect2 = distspec(trellis2,4);
berub2 = bercoding(EbN0,'conv','soft',1/2,spect2); % BER bound
spect3 = distspec(trellis3,4);
berub3 = bercoding(EbN0,'conv','soft',1/2,spect3); % BER bound



theoryBER = 0.5*erfc(sqrt(10.^(EbN0/10)));      

semilogy(EbN0,theoryBER,'g')                    % Theoretical uncoded
hold on 
load e1.mat;                                    % Encoder 1
semilogy(EbN0,BER,'ro')
hold on
load e2.mat;                                    % Encoder 2
semilogy(EbN0,BER,'blueo')
hold on
load e3.mat;                                    % Encoder 2
semilogy(EbN0,BER,'mo')



hold on
semilogy(EbN0,berub1,'r')                  % Upper-bound
hold on
semilogy(EbN0,berub2,'blue')                  % Upper-bound
hold on
semilogy(EbN0,berub3,'m')                  % Upper-bound




leg1 = legend('Uncoded (theoretical)','$\epsilon_{1}$ (simulation)','$\epsilon_{2}$ (simulation)','$\epsilon_{3}$ (simulation)',...
              'Upper bound $\epsilon_{1}$', 'Upper bound $\epsilon_{2}$', 'Upper bound $\epsilon_{3}$');
            
set(leg1,'Interpreter','latex');
set(leg1,'FontSize',12);


title('BER vs. E_{b}/N_{0}. Soft-receiver QPSK.')
xlabel('E_{b}/N_{0} [dB]')
ylabel('BER')
axis([-1 10 10^-5 1])
grid on