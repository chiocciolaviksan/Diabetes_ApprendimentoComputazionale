%% Si selezionino i nuovi attributi che consentono di descrivere oltre l’85% della
   %variabilità
autovalori= [0.2372;
            12.4054;
            67.4964;
            517.7969];
autovalori(4)/sum(autovalori)
E=[0.5062 0.5673 0.6460 -0.0678;
 0.4933 -0.5440 0.0200 -0.6785;
 0.5156 0.4036 -0.7553 0.0290;
 0.4844 -0.4684 0.1085 0.7309];
%% b Si	proiettino	nel	nuovo	spazio	i	seguenti	dati	già	depurati	dalla	media
dato=[-0.4615 -22.1538 -5.7692 30.0 ;
      -6.4615 -19.1538 3.2308 22.0;
      3.5385 7.8462 -3.7692 -10.0];
ris=dato*E(:,4); %36.8223 classe 0 
                %29.6074 classe 0
                %-12.9819 classe 1
 %% c Si classifichi il punto: [3.5385 -17.1538 -3.7692 17.0000]
 % moltiplico [3.5385 -17.1538 -3.7692 17.0000]*E(:,4)
 risultato= [3.5385 -17.1538 -3.7692 17.0000]*E(:,4);
 %ottengo 23.7149 classe 0
 
 %% prova 2 settembre 2020
 clear all
 clc
E=[0.0310	0.0215 0.0570 0.9977;
 0.1400	0.3174 0.9357 -0.0646;
 -0.9896 0.0524	0.1319 0.0221;
 -0.0071 -0.9466 0.3224	0.0022]
A=[0.3116	0.6219	2.8946	51.1222];
%scegliere componenti principali che descrivono almeno il 90% della
%varianza
componente_princ= A(4)/sum(A)
%se metto in ordine decrescente il vettore A, la prima componente è quella
%principale ovvero 51.1222

%% proiettare i dati seguenti già depurati dalla media:
dati= [ 6.6834	-0.5570	-0.3081	-0.7542 ;
       -3.6818	 2.9974	-0.4473	 0.1868 ;
        3.0983	-0.8442	 0.1133	-1.1047;
       -1.7102	-2.6443	 0.1070	-1.0040];
proiezione= dati*E(:,4);
%risultato:
%    6.6955 classe 0 positivo
%   -3.8764 classe 1 negativo
%    3.1458 classe 0 positivo
%   -1.5353 classe 1 negativo
Z=	[-12.4982 -0.5751 -1.0708 0.1026; 9.4697	-1.2284	-0.2359	1.6421];

risultato= Z*E(:,4);

