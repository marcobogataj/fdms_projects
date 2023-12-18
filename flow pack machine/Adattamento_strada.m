function  mot = Adattamento_strada( DBMotori, Load, nTMax) 
%% Function file per la selezione del motore/trasmisione
   
%% Dati del carico
Cu_rms=Load.Cu_rms;     
Cu_max=Load.Cu_max;

wpc_rms=Load.wpc_rms;
wpc_max=Load.wpc_max;
wc_max=Load.wc_max;

Jr = Load.Jr;

%% calcola i valori di Far_rms e Far_max (fattori acceleranti del carico)
Far_rms = Cu_rms; % fattore accelerante 
Far_max = Cu_max; % fattore cinetico

disp(['Valore Far_rms = ', num2str(Far_rms)] );
disp(['Valore Far_max = ', num2str(Far_max)] );

%% calcola il valore di Er_max (fattore cinetico del carico)
Er_max = sqrt(Jr)*wc_max; % fattore cinetico

disp(['Valore Er_max = ', num2str(Er_max)] );

%% calcola i valori di Fam_rms, Fam_max, Em_max  in funzione di σ

sigma = 0.05:0.01:10;
f_sigma = (1+sigma.^2)./sigma; %compute f(σ)

Fam_rms = Far_rms*f_sigma;
Fam_max = Far_max*f_sigma;
Em_max = Er_max./sigma;

%% dati dei motori
% campi della struttura motore:  Codice,  CN, Jm, nMAX
% la variabile <mot> è un array di strutture
[mot]=feval( DBMotori);  

nm = length(mot); 

%% (TO DO!!!!!!!) Calcola FaM_n, FaM_max e EM_max. Poi salva nella variabile <mot> 
for i=1:nm
       % vel massima lato 1, in rpm
 mot(i).nMAX1 = min(mot(i).nMAX,nTMax) ;     
 wMAX1=mot(i).nMAX1*2*pi/60;
 mot(i).FaM_n  = mot(i).CN/sqrt(mot(i).Jm);     
 mot(i).FaM_max  = mot(i).Tmax/sqrt(mot(i).Jm);
 mot(i).EM_max  = sqrt(mot(i).Jm)*wMAX1;

end    

%struttura mot(i) = struct('Codice','MSS-6', 'CN', 1.83, 'Jm',   0.00040, 'nMAX', 6000);

%% 
disp('Tabella motori e rapporti di trasmissione');
Tablemot = struct2table(mot);  %solo per visualizzazione
disp(Tablemot);

%%
labels={mot.Codice};  % Codici motori

%% Grafico K-P in scala logaritmica (max)
figure('color','white', 'Name','Fa_m-E_m scala logaritmica');
 loglog( Em_max, Fam_max, '--r', 'linewidth',2); hold on;
 loglog( Em_max, Fam_rms, '--k', 'linewidth',2); hold on;

 loglog( [mot.EM_max], [mot.FaM_max], 's r', 'linewidth',2); hold on;
 loglog( [mot.EM_max], [mot.FaM_n], 's k', 'linewidth',2); hold on;
 text([mot.EM_max], [mot.FaM_max], labels,'VerticalAlignment','top','HorizontalAlignment','right')
 text([mot.EM_max], [mot.FaM_n], labels,'VerticalAlignment','top','HorizontalAlignment','right')

 xlabel('E_m'); ylabel('Fa_m');  grid on
 legend('Fam_max','Fam_rms');
