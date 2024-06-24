%% ----------------------------------------------------------- %
% Analisi dei risultati di Test & Score
clear all
close all


% Training set SMOTE 
Random = [0.8478464021748364	0.7850877192982456	0.7887091705447773	0.7991377101056865	0.7850877192982456	0.5510607948961899];
Naive = [0.8530711069577777	0.7675438596491229	0.7727784151425221	0.7962825410299944	0.7675438596491229	0.5360099757881742];
Logistic = [0.8419845382720245	0.7456140350877193	0.7504457165641376	0.76448883679254	0.7456140350877193	0.47334234146142395];
SVM = [0.8498853113584233	0.7412280701754386	0.7468480090230599	0.7673657182171113	0.7412280701754386	0.4756240731352333];
kNN = [0.8115283323421969	0.7368421052631579	0.7426680119726604	0.7646070516096065	0.7368421052631579	0.46878183597305234];
Tree = [0.6811655764166171	0.7105263157894737	0.7141160192147035	0.7204178703164021	0.7105263157894737	0.3809477566803176];


% ---------------------------------------------------------------------------------------- %
% Calcolo tutti i vettori da plottare
i=1;
AUC = [Naive(i) Random(i) Tree(i) kNN(i) SVM(i) Logistic(i)];
somenames = {'Naive'; 'RF'; 'Tree'; 'kNN'; 'SVM'; 'LR'};

% CA
i=2;
CA = [Naive(i); Random(i); Tree(i); kNN(i); SVM(i); Logistic(i)];

% F1
i=3;
F1 = [Naive(i); Random(i); Tree(i); kNN(i); SVM(i); Logistic(i)];

% Precision
i=4;
Prec = [Naive(i); Random(i); Tree(i); kNN(i); SVM(i); Logistic(i)];

% Recall
i=5;
Rec = [Naive(i); Random(i); Tree(i); kNN(i); SVM(i); Logistic(i)];

% MCC
i=6;
MCC = [Naive(i); Random(i); Tree(i); kNN(i); SVM(i); Logistic(i)];


%% ------------------------------------%
% plotto i risultati otenuti
figure('Name','Valutazione')

% AUC
subplot(2,3,1)
bar(AUC)
set(gca,'xticklabel',somenames)
% legend('Naive Bayes', 'Random Forest', 'Tree', 'kNN', 'SVM', 'Logistic Regression')
title('AUC')

% CA
subplot(2,3,2)
bar(CA)
set(gca,'xticklabel',somenames)
title('Accuratezza')

% F1
subplot(2,3,3)
bar(F1)
set(gca,'xticklabel',somenames)
title('F1')

% Precision
subplot(2,3,4)
bar(Prec)
set(gca,'xticklabel',somenames)
title('Precision')

% Recall
subplot(2,3,5)
bar(Rec)
set(gca,'xticklabel',somenames)
title('Recall')

% MCC
subplot(2,3,6)
bar(MCC)
set(gca,'xticklabel',somenames)
title('MCC')

