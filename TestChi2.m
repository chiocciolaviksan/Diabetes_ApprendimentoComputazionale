%% Test del Chi2
% attenzione che chi2gof in matlab compara la distribuzione dei dati con la
% normale standard e non esegue un effettivo test del chi2

clear all
close all
clc

% Matrici di confusione A 
A = [110, 33; 15, 64];  % Esempio di matrice di confusione A (2x2)
a = A(1,1);
b = A(1,2);
c = A(2,1);
d = A(2,2);

n1 = 149;
n2 = 79;
n3 = 131;
n4 = 97;

% chi2
T = (((a*d) - (b*c))^2)/(n1*n2*n3*n4);

% distribuito come 
% ~X2 con (k-1)(n-1) gdl
k = 2;
n = 228;
dof = (k-1)*(n-1); % degree of freedom
alpha = 0.05;

% intervallo di confidenza
soglia = chi2inv((1-alpha),dof);
p_value = 1-chi2cdf(T,dof)