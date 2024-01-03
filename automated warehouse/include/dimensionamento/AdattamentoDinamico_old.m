function  mot = AdattamentoDinamico( DBMotori, Load, nTMax) 
%% Function file per la selezione del motore/trasmisione
   
%% Dati del carico
Cu_rms=Load.Cu_rms;
Cu_max= Load.Cu_max;
Lc=Load.Lc;               % variabili di servizio
wpc_rms=Load.wpc_rms;
wpc_max=Load.wpc_max;
wc_max=Load.wc_max;

%% calcola i valori ottimi di P e K  del carico con i valori di rms
PcOT_rms = 2*(wpc_rms*Cu_rms+Lc);   %tasso di potenza in condizioni di ottimo
KcOT_rms = Cu_rms/wpc_rms*wc_max^2; %energia cinetica in condizioni di ottimo

disp(['Valore PcOT_rms = ', num2str(PcOT_rms)] );
disp(['Valore KcOT_rms = ', num2str(KcOT_rms)] );

PcOT_max = 2*(wpc_max*Cu_max+Lc);   %tasso di potenza in condizioni di ottimo per valori massimi
KcOT_max = Cu_max/wpc_max*wc_max^2; %energia cinetica in condizioni di ottimo per valori massimi

disp(['Valore PcOT_max = ', num2str(PcOT_max)] );
disp(['Valore KcOT_max = ', num2str(KcOT_max)] );


%% calcola i valori ottimi di F e E  del carico  
FcOT_rms = sqrt(PcOT_rms); % fattore accelerante in condizione di ottimo
EcOT_rms = sqrt(KcOT_rms); % fattore cinetico in condizione di ottimo

disp(['Valore FcOTT = ', num2str(FcOT_rms)] );
disp(['Valore EcOTT = ', num2str(EcOT_rms)] );

FcOT_max = sqrt(PcOT_max); % fattore accelerante in condizione di ottimo per valore massimo
EcOT_max = sqrt(KcOT_max); % fattore cinetico in condizione di ottimo per valore massimo

disp(['Valore FcOT_max = ', num2str(FcOT_max)] );
disp(['Valore EcOT_max = ', num2str(EcOT_max)] );
%% dati dei motori
% campi della struttura motore:  Codice,  CN, Jm, nMAX
% la variabile <mot> è un array di strutture
[mot]=feval( DBMotori);  

nm = length(mot); 

%% Calcola Km e Pm e li salva nella variabile <mot>
for i=1:nm
       % vel massima lato 1, in rpm
 mot(i).nMAX1 = min(mot(i).nMAX,nTMax) ;     
 wMAX1=mot(i).nMAX1*2*pi/60;

 mot(i).Pm_rms  = mot(i).CN^2/mot(i).Jm;     
 mot(i).Km_rms  = mot(i).Jm*wMAX1^2;

 mot(i).Pm_max  = mot(i).Tmax^2/mot(i).Jm;     
 mot(i).Km_max  = mot(i).Jm*wMAX1^2;

 mot(i).Fm_rms  = sqrt(mot(i).Pm_rms);     
 mot(i).Em_rms  = sqrt(mot(i).Km_rms);

 mot(i).Fm_max  = sqrt(mot(i).Pm_max);     
 mot(i).Em_max  = sqrt(mot(i).Km_max);   
end    

%struttura mot(i) = struct('Codice','MSS-6', 'CN', 1.83, 'Jm',   0.00040, 'nMAX', 6000);

%% Calcolo dei rapporti di riduzione   
for i=1:nm
    tauOTT = sqrt(mot(i).Jm*wpc_rms/Cu_rms);   
    mot(i).IOTT  = 1/tauOTT;   
    
    DP = mot(i).Pm_rms-PcOT_rms;   
    if( DP>=0)
        % cacolare i rapporti di trasmissione dimamici  
        tauMAX = sqrt(mot(i).Jm)*(sqrt(DP+4*Cu_rms*wpc_rms)+sqrt(DP))/(2*Cu_rms);   
        tauMIN = sqrt(mot(i).Jm)*(sqrt(DP+4*Cu_rms*wpc_rms)-sqrt(DP))/(2*Cu_rms);  
    else
        % non passano la selezone di coppia li setto a infinito 
        tauMIN = inf;  
        tauMAX = inf;
    end
    % rapporto di riduzione massimo cinematico
    wMAX1=mot(i).nMAX1*2*pi/60;
    ImaxC = wMAX1/wc_max;  
    ImaxD =  1/tauMIN;   % rapporto di riduzione massimo dinamico
    IminD =  1/tauMAX;   % rapporto di riduzione minimo dinamico
    Imax =  min(ImaxC,ImaxD); % valore massimo di i 
    if Imax > IminD     
          % salvo i valori nella struttura mot(i)
        mot(i).Imin  = IminD;
        mot(i).Imax  = Imax;
    else
        % in questo caso non è posibile accopiare il motore con il carico 
        % setto a 0 Imin e Imax
        mot(i).Imin  = 0;
        mot(i).Imax  = 0;
    end
end

%% 
disp('Tabella motori e rapporti di trasmissione');
Tablemot = struct2table(mot);  %solo per visualizzazione
disp(Tablemot);

%%
labels={mot.Codice};  % Codici motori

figure('color','white', 'Name','Rapporti di riduzione'); 
plot([mot.IOTT], 'D k', 'MarkerSize',6); hold on;
plot([mot.Imin], 'X b', 'MarkerSize',10);
plot([mot.Imax], 'X r', 'MarkerSize',10); 
legend('$i_{OTT}$','$i_{min}$','$i_{max}$','interpreter','latex');
xticklabels(labels);
xlabel('# motori'); ylabel('i'); grid on;

%% Rappresentazione grafica in K-P
s =  linspace(0.05,10, 100);     % sigma 
p_s = (s-1./s).^2;  % p(sigma)
k_s  = 1./s.^2;      % k(sigma)  

% calcola i valori di P e K al variare di sigma
Pc_rms =  PcOT_rms+p_s*Cu_rms*wpc_rms;    
Kc_rms  = KcOT_rms*k_s; 

    Fc_rms= sqrt(Pc_rms); %fattore accelerante del carico in funzione di sigma
    Ec_rms= sqrt(Kc_rms); %fattore cinetico del carico in funzione di sigma

Pc_max =  PcOT_max+p_s*Cu_max*wpc_max;    
Kc_max  = KcOT_max*k_s; 

    Fc_max= sqrt(Pc_max); %fattore accelerante del carico in funzione di sigma
    Ec_max= sqrt(Kc_max); %fattore cinetico del carico in funzione di sigma


%DA INSERIRE SC (sigma carico=tau/tau_OTT=i_OTT/i) PER CALCOLARE IL PUNTO
sc=439.17/24; %sigma
p_sc = (sc-1/sc)^2; 
k_sc  = 1/sc^2;      
Pcarico_rms=PcOT_rms+p_sc*Cu_rms*wpc_rms;  
Kcarico_rms=KcOT_rms*k_sc;
    Fcarico_rms=sqrt(Pcarico_rms);  
    Ecarico_rms=sqrt(Kcarico_rms);
disp(['Valore Pcarico_rms = ', num2str(Pcarico_rms)]);
disp(['Valore Kcarico_rms = ', num2str(Kcarico_rms)]);
    disp(['Valore Fcarico_rms = ', num2str(Fcarico_rms)]);
    disp(['Valore Ecarico_rms = ', num2str(Ecarico_rms)]);

Pcarico_max=PcOT_max+p_sc*Cu_max*wpc_max;  
Kcarico_max=KcOT_max*k_sc;
    Fcarico_max=sqrt(Pcarico_max);  
    Ecarico_max=sqrt(Kcarico_max);
disp(['Valore Pcarico_max = ', num2str(Pcarico_max)]);
disp(['Valore Kcarico_max = ', num2str(Kcarico_max)]);
    disp(['Valore Fcarico_max = ', num2str(Fcarico_max)]);
    disp(['Valore Ecarico_max = ', num2str(Ecarico_max)]);


%% Grafico K-P in scala logaritmica 
figure('color','white', 'Name','K-P scala logaritmica');
 loglog( [mot.Km_rms], [mot.Pm_rms], 's b', 'linewidth',2); hold on;
 text([mot.Km_rms], [mot.Pm_rms], labels, ...
         'VerticalAlignment','top','HorizontalAlignment','right')
 loglog(  KcOT_rms, PcOT_rms,'D r','linewidth',2); 
loglog(  Kcarico_rms, Pcarico_rms,'D g','linewidth',2); %plot del punto di carico scelto
 loglog(  Kc_rms, Pc_rms,'--k','linewidth',2);
 legend(  'Motori', 'OTT', 'Pc-Kc' );
 ylim([PcOT_rms/10,inf]); 
 xlabel('K'); ylabel('P');  grid on

 %% Grafico F_rms-E_rms in scala logaritmica 
figure('color','white', 'Name','E_rms-F_rms scala logaritmica');
 loglog( [mot.Em_rms], [mot.Fm_rms], 's b', 'linewidth',2); hold on;
 text([mot.Em_rms], [mot.Fm_rms], labels, ...
         'VerticalAlignment','top','HorizontalAlignment','right')
 loglog(  EcOT_rms, FcOT_rms,'D r','linewidth',2); 
loglog(  Ecarico_rms, Fcarico_rms,'D g','linewidth',2); %plot del punto di carico scelto
 loglog(  Ec_rms, Fc_rms,'--k','linewidth',2);
 legend(  'Motori', 'OTT', 'Fc-Ec' );
 ylim([FcOT_rms/10,inf]); 
 xlabel('E_{rms}'); ylabel('F_{rms}');  grid on

  %% Grafico F_max-E_max in scala logaritmica 
figure('color','white', 'Name','E_max-F_max scala logaritmica');
 loglog( [mot.Em_max], [mot.Fm_max], 's b', 'linewidth',2); hold on;
 text([mot.Em_max], [mot.Fm_max], labels, ...
         'VerticalAlignment','top','HorizontalAlignment','right')
 loglog(  EcOT_max, FcOT_max,'D r','linewidth',2); 
loglog(  Ecarico_max, Fcarico_max,'D g','linewidth',2); %plot del punto di carico scelto
 loglog(  Ec_max, Fc_max,'--k','linewidth',2);
 legend(  'Motori', 'OTT', 'Fc-Ec' );
 ylim([FcOT_max/10,inf]); 
 xlabel('E_{max}'); ylabel('F_{max}');  grid on

%% Eventulamente fare lo stesso grafico K-P in scala lineare 