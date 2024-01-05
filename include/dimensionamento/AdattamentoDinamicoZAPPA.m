function  mot = AdattamentoDinamicoZAPPA( DBMotori, Load, nTMax, m, T) 
%% Function file per la selezione del motore/trasmisione
   
%% Dati del carico
Cu_rms=Load.Cu_rms;     
Cu_max=Load.Cu_max;
Lc=Load.Lc;              
wpc_rms=Load.wpc_rms;
wpc_max=Load.wpc_max;
wc_max=Load.wc_max;

%% calcola i valori ottimi di P e K  del carico (rms)
PcOTT = 2*(wpc_rms*Cu_rms+Lc);  %tasso di potenza
KcOTT = Cu_rms/wpc_rms*wc_max^2; %energia cinetica 

%% calcola i valori ottimi di F e E  del carico (rms) 
FcOTT = sqrt(PcOTT); % fattore accelerante 
EcOTT = sqrt(KcOTT); % fattore cinetico

disp(['Valore FcOTT = ', num2str(FcOTT)] );
disp(['Valore EcOTT = ', num2str(EcOTT)] );

%% calcola i valori ottimi di F  del carico (max) 
PcOTT_max = 4*(wpc_max*Cu_max);  %tasso di potenza
FcOTT_max = sqrt(PcOTT_max); % fattore accelerante 

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
 mot(i).Pm  = mot(i).CN^2/mot(i).Jm;     
 mot(i).Pm_max  = mot(i).Cm_max^2/mot(i).Jm;   
 mot(i).Km  = mot(i).Jm*wMAX1^2;
 mot(i).Fm  = sqrt(mot(i).Pm); 
 mot(i).Fm_max  = sqrt(mot(i).Pm_max); 
 mot(i).Em  = sqrt(mot(i).Km);  

end    

%struttura mot(i) = struct('Codice','MSS-6', 'CN', 1.83, 'Jm',   0.00040, 'nMAX', 6000);

%% Calcolo dei rapporti di riduzione   
for i=1:nm
    tauOTT = sqrt(mot(i).Jm*wpc_rms/Cu_rms);   
    mot(i).IOTT  = 1/tauOTT;   
    
    DP = mot(i).Pm-PcOTT;   
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
xlabel('# motori'); ylabel('i'); grid on;
set(gca,'xtick',1:nm,'xticklabel',labels);

%% Rappresentazione grafica in K-P
s =  linspace(0.05,10, 100);     % sigma 
p_s = (s-1./s).^2;  % p(sigma)
k_s  = 1./s.^2;      % k(sigma)  
f_s = 1/4*(s+1./s).^2;

% calcola i valori di P e K al variare di sigma
Pc =  PcOTT+p_s*Cu_rms*wpc_rms;  
Pc_max = PcOTT_max*f_s;
Kc  = KcOTT*k_s; 
%
%DA INSERIRE SC (sigma carico=tau/tau_OTT=i_OTT/i) PER CALCOLARE IL PUNTO
sc= mot(m).IOTT /T.i; %sigma
p_sc = (sc-1/sc)^2; 
k_sc  = 1/sc^2;      
Pcarico=PcOTT+p_sc*Cu_rms*wpc_rms;  
Kcarico=KcOTT*k_sc; 
Fcarico = sqrt(Pcarico);
Ecarico = sqrt(Kcarico);

 %% Grafico F-E in scala logaritmica 
figure('color','white', 'Name','E-F scala logaritmica');
 loglog( [mot.Em], [mot.Fm], 's b', 'linewidth',2); hold on;
 text([mot.Em], [mot.Fm], labels, ...
         'VerticalAlignment','top','HorizontalAlignment','right')
 loglog( [mot.Em], [mot.Fm_max], 's m', 'linewidth',2); hold on;
 text([mot.Em], [mot.Fm_max], labels, ...
         'VerticalAlignment','top','HorizontalAlignment','right')

 loglog(  sqrt(Kc), sqrt(Pc),'--b','linewidth',2);
 loglog(  sqrt(Kc), sqrt(Pc_max),'--m','linewidth',2);
 loglog(  Ecarico, Fcarico,'D g','linewidth',2);
 
 legend(  'Motors (rms)','Motors (max)','Fc - Ec','Fc max - Ec max','PL' );
 ylim([FcOTT/10,inf]); 
 xlabel('E'); ylabel('F');  grid on
