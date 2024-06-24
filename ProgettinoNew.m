%% progettino
clear all 
close all
clc

% carico il mio file: mentre in orange lho dovuto convertire in csv 
% (valori separati da virgola) - qua invece li carico in formato .data
load pima-indians-diabetes.data
PID = pima_indians_diabetes;

% pregnancies
pregnancies = PID(:,1);
glucose = PID(:,2);
bloodPres = PID(:,3);
skin = PID(:,4);
insuline = PID(:,5);
bmi = PID(:,6);
dpf = PID(:,7);
age = PID(:,8);
classi = PID(:,9);

%% ------------------------------------------------------------------------ %
% metto i NaN

N = PID;
N(N(:,2)==0,2)=NaN;
N(N(:,3)==0,3)=NaN;
N(N(:,4)==0,4)=NaN;
N(N(:,5)==0,5)=NaN;
N(N(:,6)==0,6)=NaN;

ConNaN = [pregnancies N(:,2) N(:,3) N(:,4) N(:,5) N(:,6) dpf age classi];
csvwrite('fileNaN.csv',ConNaN);

%% ------------------------------------------------------------------------ %
% matrice di correlazione e grafico

R1 = corr(N,'rows','complete','Type','Kendall');

h1 = heatmap(R1);
h1.XDisplayLabels = {'Pregnancies','Glucose','Blood Pressure','Skin Thickness','Insuline','BMI','DPF','Age','Outcome'};
h1.YDisplayLabels = {'Pregnancies','Glucose','Blood Pressure','Skin Thickness','Insuline','BMI','DPF','Age','Outcome'};

x = [1 2 3 4 5 6 7 8];
cor1 = R1(x,9);
corr1 = flip(sort(cor1));
labels = {'Glucose','Age','Insuline','BMI','Skin Thickness','Pregnancies','Blood Pressure','DPF'};

figure('Name', 'Correlation Graph')
bar(x,corr1,'BarWidth',0.2);
axis([0 9 0 0.5])
set(gca,'xticklabel',labels)


%% ----------------------------------------------------------------------- %
% Histogrammi ORIGINALI

figure('Name','Histogram before')

subplot(2,5,1)
histogram(pregnancies,17,'Normalization','count')
axis([min(pregnancies)-3 max(pregnancies)+3 0 150])
ylabel('Frequenza')
title('Pregnancies')

subplot(2,5,2)
histogram(glucose,10,'Normalization','count')
axis([min(glucose)-10 max(glucose)+10 0 220])
title('Glucose')

subplot(2,5,3)
histogram(bloodPres,10,'Normalization','count')
axis([min(bloodPres)-10 max(bloodPres)+10 0 300])
title('Blood Pressure')

subplot(2,5,4)
histogram(skin,10,'Normalization','count')
axis([min(skin)-10 max(skin)+10 0 240])
title('Skin Thickness')

subplot(2,5,5)
histogram(insuline,10,'Normalization','count')
axis([min(insuline)-70 max(insuline)+70 0 500])
title('Insuine')

subplot(2,5,6)
histogram(bmi,10,'Normalization','count')
axis([min(bmi)-20 max(bmi)+20 0 290])
ylabel('Frequenza')
title('BMI')

subplot(2,5,7)
histogram(dpf,10,'Normalization','count')
axis([min(dpf)-1 max(dpf)+1 0 300])
title('DPF')

subplot(2,5,8)
histogram(age,10,'Normalization','count')
axis([min(age)-10 max(age)+10 0 240])
title('Age')

subplot(2,5,9)
histogram(classi,2,'Normalization','count')
axis([min(classi)-1 max(classi)+1 0 550])
title('Class')



%% -------------------------------------------------------------------------- %
% istogrammi coi NaN

% pregnancies
pregnancies = PID(:,1);
glucose = N(:,2);
bloodPres = N(:,3);
skin = N(:,4);
insuline = N(:,5);
bmi = N(:,6);
dpf = PID(:,7);
age = PID(:,8);
classi = PID(:,9);

figure('Name','Histogram before')

subplot(2,5,1)
histogram(pregnancies,17,'Normalization','count')
axis([min(pregnancies)-3 max(pregnancies)+3 -5 150])
ylabel('Frequenza')
title('Pregnancies')

subplot(2,5,2)
histogram(glucose,10,'Normalization','count')
axis([min(glucose)-10 max(glucose)+10 -5 180])
title('Glucose')

subplot(2,5,3)
histogram(bloodPres,10,'Normalization','count')
axis([min(bloodPres)-10 max(bloodPres)+10 -5 280])
title('Blood Pressure')

subplot(2,5,4)
histogram(skin,10,'Normalization','count')
axis([min(skin)-10 max(skin)+10 -5 190])
title('Skin Thickness')

subplot(2,5,5)
histogram(insuline,10,'Normalization','count')
axis([min(insuline)-70 max(insuline)+70 -5 170])
title('Insuine')

subplot(2,5,6)
histogram(bmi,10,'Normalization','count')
axis([min(bmi)-20 max(bmi)+20 -5 250])
ylabel('Frequenza')
title('BMI')

subplot(2,5,7)
histogram(dpf,10,'Normalization','count')
axis([min(dpf)-1 max(dpf)+1 -5 300])
title('DPF')

subplot(2,5,8)
histogram(age,10,'Normalization','count')
axis([min(age)-10 max(age)+10 -5 240])
title('Age')

subplot(2,5,9)
histogram(classi,2,'Normalization','count')
axis([min(classi)-1 max(classi)+1 -5 550])
title('Class')


%% -------------------------------------------------------------------------- %
% boxplot - vedo come sono messi gli outliers secondo matlab

figure('Name','Boxplot before processing')
subplot(2,5,1)
boxplot(pregnancies)
title('Pregnancies')

subplot(2,5,2)
boxplot(glucose)
title('Glucose')

subplot(2,5,3)
boxplot(bloodPres)
title('Blood Pressure')

subplot(2,5,4)
boxplot(skin)
title('Skin Thickness')

subplot(2,5,5)
boxplot(insuline)
title('Insuline')

subplot(2,5,6)
boxplot(bmi)
title('BMI')

subplot(2,5,7)
boxplot(dpf)
title('DPF')

subplot(2,5,8)
boxplot(age)
title('Age')

subplot(2,5,9)
boxplot(classi)
title('Class')




%% -------------------------------------------------------------------- %
clear i k
clear out_Preg out_Glucose out_Blood out_Skin 
clear out_BMI out_DPF out_Age out_Insuline out_Class

% Gestione degli Outliers
% dalla vista degli istogrammi 'after' è possibile notare la presenza di
% alcuni outliers. Siccome si tratta di pochi dati < 5% allora elimino le righe

outBP = find(bloodPres > 120);           
outSkin = find(skin > 70);
outInsuline = find(insuline > 700);
outBMI = find(bmi > 60);
outAge = find(age > 80); 
infInsuline = find(insuline < 15);
indici = [outBP' outSkin' outInsuline' outBMI' outAge' infInsuline'];
indice = sort(indici);

k=1;
j=0;
tot = length(pregnancies);

for i=1:tot
    if (i == indice(1) || i==(indice(2)-1) || (i==indice(3)-2) ...
            || (i==indice(4)-3) || (i==indice(5)-4) || (i==indice(6)-5) || (i==indice(7)-6))
        j = j+1;
    end
    if(i+j > 768)
        break;
    end
    out_Preg(k) = pregnancies(i+j);
    out_Glucose(k) = glucose(i+j);
    out_Blood(k) = bloodPres(i+j);
    out_Skin(k) = skin(i+j);
    out_BMI(k) = bmi(i+j);
    out_DPF(k) = dpf(i+j);
    out_Age(k) = age(i+j);
    out_Insuline(k) = insuline(i+j);
    out_Class(k) = classi(i+j);
    k = k+1;
end


%% ----------------------------------------------------------------------- %
% Gestione dei dati Nulli/Mancanti

% gestione degli outliers: Although in this dataset none of the columns 
% contain missing values, some of the measurements (Glucose, Blood Pressure, 
% Skin Thickness, Insulin and BMI) have values of 0, which is not possible 
% for a living human organism.

tot = length(out_Glucose);

% trovo quanti datinulli ha il mio dataset
gluc0 = sum(isnan(out_Glucose));
bloodPress0 = sum(isnan(out_Blood));
skin0 = sum(isnan(out_Skin));
ins0 = sum(isnan(out_Insuline));
bmi0 = sum(isnan(out_BMI));

percGluc = (gluc0*100)/tot;
percBP = (bloodPress0*100)/tot;
percSkin = (skin0*100)/tot;
percIns = (ins0*100)/tot;
percBMI = (bmi0*100)/tot;

fid = fopen('DatiNulli.txt','w');
fprintf(fid,'\n DATI NULLI \n');

fprintf(fid,'\n\n\n Feature     Count(0)    Percentuale');
fprintf(fid,'\n -----------------------------------');
fprintf(fid,'\n%s\t\t\t%d\t\t%f\t%s','Glucose',round(gluc0),percGluc,'%');
fprintf(fid,'\n%s\t\t\t%d\t\t%f\t%s','BloodPR',round(bloodPress0),percBP,'%');
fprintf(fid,'\n%s\t\t\t%d\t\t%f\t%s','SkinTck',round(skin0),percSkin,'%');
fprintf(fid,'\n%s\t\t\t%d\t\t%f\t%s','Insulin',round(ins0),percIns,'%');
fprintf(fid,'\n%s\t\t\t%d\t\t%f\t%s','BMI ind',round(bmi0),percBMI,'%');

fprintf(fid,'\n\n\n\n\n');
fclose(fid);


%% ----------------------------------------------------------------------------- %
% rimozione dei NaN e Imputing con mediana

index = find(isnan(out_Glucose) == 1);
out_Glucose(index) = median(out_Glucose,'omitNaN');

clear index
index = find(isnan(out_Blood) == 1);
out_Blood(index) = median(out_Blood,'omitNaN');

clear index
index = find(isnan(out_Skin) == 1);
out_Skin(index) = median(out_Skin,'omitNaN');

clear index
index = find(isnan(out_BMI) == 1);
out_BMI(index) = median(out_BMI,'omitNaN');

% creazione della matrice dei dati 
% senza outliers
% senza NaN - Imputing
% senza Insuline
clear DATA
DATA(:,1) = out_Preg;
DATA(:,2) = out_Glucose;
DATA(:,3) = out_Blood;
DATA(:,4) = out_Skin;
DATA(:,5) = out_BMI;
DATA(:,6) = out_DPF';
DATA(:,7) = out_Age';
DATA(:,8) = out_Class';


csvwrite('fileImputE.csv',DATA);


%% ---------------------------------------------------------------------------- %
% analisi pre-normalizzazione
clc
x = [1 2 3 4 5 6 7];
Medie = mean(DATA(:,x));
Deviazion = std(DATA(:,x));

fid = fopen('MedieStedev.txt','w');
fprintf(fid,'\n MEDIE - DEVIAZIONI \n');

fprintf(fid,'\n\n\n Feature        Media           SteDev');
fprintf(fid,'\n ---------------------------------------');
fprintf(fid,'\n%s\t\t%f\t\t%f\t','Pregnancies',Medie(1),Deviazion(1));
fprintf(fid,'\n%s\t\t\t%f\t\t%f\t','Glucose',Medie(2),Deviazion(2));
fprintf(fid,'\n%s\t\t\t%f\t\t%f\t','BloodPR',Medie(3),Deviazion(3));
fprintf(fid,'\n%s\t\t\t%f\t\t%f\t','SkinTck',Medie(4),Deviazion(4));
fprintf(fid,'\n%s\t\t\t%f\t\t%f\t','BMI ind',Medie(5),Deviazion(5));
fprintf(fid,'\n%s\t\t\t%f\t\t%f\t','DPF fun',Medie(6),Deviazion(6));
fprintf(fid,'\n%s\t\t\t%f\t\t%f\t','Age    ',Medie(7),Deviazion(7));


% ------------------------------------------------------------------------------ %
% Normalizzazione
% va fatta su tutto il dataset e lo faccio ramite la widget di orange,
% rendendo i dati tra [0,1]. leggo il file in output da Orange 
% dopo averli salvati in .tab li converto in .xlsx e importo la tabella

FileNorm = readtable("fileNorm.xlsx");

% calcolo le medie e le deviazioni anche dei dati normalizzati
A = FileNorm(:,x);
Tab = table2array(A);


fprintf(fid,'\n\n\n MEDIE - DEVIAZIONI post NORMALIZZAZIONE \n');
fprintf(fid,'\n Feature        Media           SteDev');
fprintf(fid,'\n ---------------------------------------');
fprintf(fid,'\n%s\t\t%f\t\t%f\t','Pregnancies',media(1),deviazione(1));
fprintf(fid,'\n%s\t\t\t%f\t\t%f\t','Glucose',media(2),deviazione(2));
fprintf(fid,'\n%s\t\t\t%f\t\t%f\t','BloodPR',media(3),deviazione(3));
fprintf(fid,'\n%s\t\t\t%f\t\t%f\t','SkinTck',media(4),deviazione(4));
fprintf(fid,'\n%s\t\t\t%f\t\t%f\t','BMI ind',media(5),deviazione(5));
fprintf(fid,'\n%s\t\t\t%f\t\t%f\t','DPF fun',media(6),deviazione(6));
fprintf(fid,'\n%s\t\t\t%f\t\t%f\t','Age    ',media(7),deviazione(7));

fprintf(fid,'\n\n\n\n\n');
fclose(fid);




%% ----------------------------------------------------------- %
clear all
close all
Test = readtable("TestSet.xlsx");

Test.Properties.VariableNames=["Pregnancies","Glucose","Blood Pressure","Skin Thickness","BMI","DPF","Age","Outcome"];
writetable(Test,'Test.csv');

%% ------------------------------ %
clear all
close all
clc

Test = readtable("AugmentedTraining.csv");

Test.Properties.VariableNames=["Pregnancies","Glucose","Blood Pressure","Skin Thickness","BMI","DPF","Age","Outcome"];
writetable(Test,['Augmented_SIMO.csv']);



%% ------------------------------ %
clear all
close all
clc

Test = readtable("TestSet.csv");

Test.Properties.VariableNames=["Pregnancies","Glucose","Blood Pressure","Skin Thickness","BMI","DPF","Age","Outcome"];
writetable(Test,['test_SIMO.csv']);







