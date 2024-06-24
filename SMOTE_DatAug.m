%% ------------------------------------------------------------------------------ %
% SMOTE - Synthetic Minority Over-sampling Technique
clc
clear all

% lo faccio solo sul training set quindi devo importare il training set
% dopo la divisione in orange

x = [1 2 3 4 5 6 7 ];
Training = readtable("Training.xlsx");
A = Training(:,x);
Class_A = table2array(Training(:,end));
T = table2array(A);

% magheggio xk orange è mongolo
Training.Properties.VariableNames=["Pregnancies","Glucose","Blood Pressure","Skin Thickness","BMI","DPF","Age","Outcome"];
writetable(Training,'TrainingOriginal.csv');

% richiamo l'algoritmo SMOTE come implementato nella funzione apposita che
[B,C,Xn,Cn] = smote(T,[],3, 'Class',Class_A); 

% ------------------------------------------------------- %
% verifico se sono riuscita a ribilanciare il training set

ZeriSMOTE = sum(strcmp(C,'0'));
UniSMOTE = sum(strcmp(C,'1'));

% calcolo le percentuali delle due classi
perc_uniSMOTE = (UniSMOTE *100)/(height(C));     
perc_zeriSMOTE = (ZeriSMOTE *100)/(height(C));   

disp('percentuale classe = 1')
disp(perc_uniSMOTE )
disp('percentuale classe = 0')
disp(perc_zeriSMOTE )

% ora sono bilanciate 50 e 50


% -------------------------------------------------------------------- %
% i dati di Pregnancies e Age devono essere sistemati
% vettore 1 da arrotondare
% vettore 2 riferimento per arrotodarli

vettore1Preg = B(:,1);
vettore2Preg = unique(T(:,1));

% Arrotondamento dei dati di vettore1 al valore più simile di vettore2
vettArrPreg = zeros(size(vettore1Preg));

for i = 1:length(vettore1Preg)
    dato = vettore1Preg(i);
    [~, indice_simile] = min(abs(vettore2Preg - dato));
    vettArrPreg(i) = vettore2Preg(indice_simile);
end

% Faccio la stessa cosa con Age
vettore1Age = B(:,7);
vettore2Age = unique(T(:,7));

clear dato indice_simile i
vettArrAge = zeros(size(vettore1Age));

for i = 1:length(vettore1Age)
    dato = vettore1Age(i);
    [~, indice_simile] = min(abs(vettore2Age - dato));
    vettArrAge(i) = vettore2Age(indice_simile);
end

B(:,1) = vettArrPreg;
B(:,7) = vettArrAge;


% ----------------------------------------------------- %
% scrittura del file con il nuovo dataset

F = [num2cell(B),C];
F = array2table(F);

F.Properties.VariableNames=["Pregnancies","Glucose","Blood Pressure","Skin Thickness","BMI","DPF","Age","Outcome"];
writetable(F,'TrainingSMOTE5.csv');



%% ---------------------------------------------------------------------- %
% Data Augmentation
clear all
close all
clc

% reload del training set dopo il clear 
x = [1 2 3 4 5 6 7 ];
Training = readtable("Training.xlsx");
A = Training(:,x);
Class_A = table2array(Training(:,end));
T = table2array(A);

% obs_0 = 10*(strcmp(Class_A,'0'));
% obs_1 = 20*(strcmp(Class_A,'1'));
% obs = obs_0 + obs_1; 

% quante volte ogni osservazione verrà usata come base di sintesi
obs_0 = 2*(strcmp(Class_A,'0'));
obs_1 = 5*(strcmp(Class_A,'1'));
obs = obs_0 + obs_1; 

% richiamo l'algoritmo SMOTE come implementato nella funzione apposita che
[B1,C1,Xn1,Cn1] = smote(T,[],3, 'Class',Class_A,'SynthObs',obs); 
% [B1,C1,Xn1,Cn1] = smote(T,[],3, 'Class',Class_A); 

% ------------------------------------------------------- %
% verifico se sono riuscita a ribilanciare il training set

ZeriSMOTE1 = sum(strcmp(C1,'0'));
UniSMOTE1 = sum(strcmp(C1,'1'));

% calcolo le percentuali delle due classi
perc_uniSMOTE1 = (UniSMOTE1 *100)/(height(C1));     
perc_zeriSMOTE1 = (ZeriSMOTE1 *100)/(height(C1));   

disp('percentuale classe = 1')
disp(perc_uniSMOTE1 )
disp('percentuale classe = 0')
disp(perc_zeriSMOTE1 )


% -------------------------------------------------------------------- %
% i dati di Pregnancies e Age devono essere sistemati
% vettore 1 da arrotondare
% vettore 2 riferimento per arrotodarli

clear vettArrAge vettArrPreg vettore1Age vettore1Preg vettore2Age vettore2Preg
clear dato i indice_simile

vettore1Preg = B1(:,1);
vettore2Preg = unique(T(:,1));
vettore1Age = B1(:,7);
vettore2Age = unique(T(:,7));

% Arrotondamento dei dati di vettore1 al valore più simile di vettore2
vettArrPreg = zeros(size(vettore1Preg));
vettArrAge = zeros(size(vettore1Age));

for i = 1:length(vettore1Preg)
    dato = vettore1Preg(i);
    [~, indice_simile] = min(abs(vettore2Preg - dato));
    vettArrPreg(i) = vettore2Preg(indice_simile);

    dato1 = vettore1Age(i);
    [~, indice_simile1] = min(abs(vettore2Age - dato1));
    vettArrAge(i) = vettore2Age(indice_simile1);
end


B1(:,1) = vettArrPreg;
B1(:,7) = vettArrAge;


% ----------------------------------------------------- %
% scrittura del file con il nuovo dataset

F1 = [num2cell(B1),C1];
F1 = array2table(F1);

F1.Properties.VariableNames=["Pregnancies","Glucose","Blood Pressure","Skin Thickness","BMI","DPF","Age","Outcome"];
writetable(F1,'TrainingDataAug5.csv');



%% ---------------------------------------------------------------------- %
% ks test

% Determina gli indici delle righe in cui l'ultimo valore della colonna è '1'
indici_righe = find(strcmp(Class_A,'1'));      % originale Training
indici_SMOTE = find(strcmp(C,'1'));            % SMOTE
indici_DataAug = find(strcmp(C1,'1'));         % Data Augmentation 

% Estrae la sottomatrice originale 
sottomatrice = T(indici_righe,:);
sottomSMOTE = B(indici_SMOTE,:);
sottomDataAug = B1(indici_DataAug,:);


for i = 1:8

    H_SMOTE(i) = kstest2(sottomatrice(:,i),sottomSMOTE(:,i));
    H_DataAug(i) = kstest2(sottomatrice(:,i),sottomDataAug(:,i));

end





