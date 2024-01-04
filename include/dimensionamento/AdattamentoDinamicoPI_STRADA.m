function  mot = AdattamentoDinamicoPI_STRADA( DBMotori, Load, nTMax) 
%% Function file per la selezione del motore/trasmisione
   
%% Dati del carico
            
wpc_rms=Load.wpc_rms;
wpc_max=Load.wpc_max;
wc_max=Load.wc_max;
Jr=Load.Jr;

%% Far_rms, Far_max
Far_rms = sqrt(Jr) * wpc_rms;
Far_max = sqrt(Jr) * wpc_max;

Er_max = sqrt(Jr) * wc_max;

%% dati dei motori
% campi della struttura motore:  Codice,  CN, Jm, nMAX
% la variabile <mot> è un array di strutture
[mot]=feval( DBMotori);  

nm = length(mot); 

%% Calcola Fam e Em e li salva nella variabile <mot>
for i=1:nm
       % vel massima lato 1, in rpm
 mot(i).nMAX1 = min(mot(i).nMAX,nTMax) ;     
 wMAX1=mot(i).nMAX1*2*pi/60;
 mot(i).Fam_rms  = mot(i).CN/sqrt(mot(i).Jm);     
 mot(i).Fam_max  = mot(i).Cm_max/sqrt(mot(i).Jm);     
 mot(i).Em_max  = sqrt(mot(i).Jm)*wMAX1;  
end    

%struttura mot(i) = struct('Codice','MSS-6', 'CN', 1.83, 'Jm',   0.00040, 'nMAX', 6000);

%% 
disp('Tabella motori e rapporti di trasmissione');
Tablemot = struct2table(mot);  %solo per visualizzazione
disp(Tablemot);

%%
labels={mot.Codice};  % Codici motori

%% Rappresentazione grafica in K-P
s =  linspace(0.05,10, 100);     % sigma 
p_s = (s+1./s) ;  % p(sigma)
k_s  = 1./s;      % k(sigma)  

% calcola i valori di Fam_max, Fam_rms e Em_max al variare di sigma
Fam_max_s = Far_max*p_s; 
Fam_rms_s  = Far_rms*p_s; 
Em_max_s = Er_max*k_s;

 %% Grafico F-E in scala logaritmica 
figure('color','white', 'Name','E-F scala logaritmica');
 loglog( [mot.Em_max], [mot.Fam_rms], 's b', 'linewidth',2); hold on;
 text([mot.Em_max], [mot.Fam_rms], labels, ...
         'VerticalAlignment','top','HorizontalAlignment','right')

 loglog( [mot.Em_max], [mot.Fam_max], 's m', 'linewidth',2); hold on;
 text([mot.Em_max], [mot.Fam_max], labels, ...
         'VerticalAlignment','top','HorizontalAlignment','right')

 loglog(  Em_max_s, Fam_rms_s,'--b','linewidth',2);

 loglog(  Em_max_s, Fam_max_s,'--m','linewidth',2);

 legend(  'Motors (rms)','Motors (max)','rms load request','max load request' );
 ylim([Far_max/10,inf]); 
 xlabel('Em'); ylabel('Fa_m');  grid on
