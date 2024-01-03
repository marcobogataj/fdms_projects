function  mot = AdattamentoDinamico( DBMotori, Load, nTMax) 
%% Function file per la selezione del motore/trasmisione
   
%% Dati del carico
            
wpc_rms=Load.wpc_rms;
wpc_max=Load.wpc_max;
wc_max=Load.wc_max;
Jr=Load.Jr;
Cr_rms = Load.Cr_rms;
Cr_max = Load.Cr_max;
Lr = Load.Lr;

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
 mot(i).Fam_max  = mot(i).Tmax/sqrt(mot(i).Jm);     
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
Fam_max_s = Far_max*p_s + Cr_max/sqrt(Jr)*s; 
Fam_rms_s  = sqrt(Far_rms^2*p_s.^2+Cr_rms^2/Jr*s.^2+2*(1+s.^2)*Lr); 
Em_max_s = Er_max*k_s;

%% calcolo TAUmin, TAUmax

TAUott = sqrt(mot(i).Jm/Jr);
mot.IOTT = 1/TAUott;

for i=1:nm
    if mot(i).Fam_rms < min(Fam_rms_s) || mot(i).Fam_max < min(Fam_max_s) 
       %fattore accelerante motore minore del minimo fattore accelerante richiesto dal carico
       mot(i).Imin = inf;
       mot(i).Imax = inf;
        
    else
       [~,s_ix_min ] = min( abs( Em_max_s-mot(i).Em_max ));
       [~,s_ix_max ] = min( abs( Fam_rms_s-mot(i).Fam_rms ));

       s_min = s(s_ix_min);
       s_max = s(s_ix_max);

       if mot(i).Fam_rms(i) < Fam_rms_s(s_ix_min) 
           %fattore accelerante del motore minore del fattore accelerante richiesto
           %dal carico nel punto di lavoro del motore
            mot(i).Imin = inf;
            mot(i).Imax = inf;
       
       else 
            TAUmin = TAUott*s_min; 

            s_max=Er_max/mot(i).Em_max;
            TAUmin = TAUott*s_min; 

            mot(i).Imin = 1/TAUmax; 
            mot(i).Imax = 1/TAUmin;

       end 
    end
end    

labels={mot.Codice};  % Codici motori

figure('color','white', 'Name','Rapporti di riduzione'); 
plot([mot.IOTT], 'D k', 'MarkerSize',6); hold on;
plot([mot.Imin], 'X b', 'MarkerSize',10);
plot([mot.Imax], 'X r', 'MarkerSize',10); 
legend('$i_{OTT}$','$i_{min}$','$i_{max}$','interpreter','latex');
xticklabels(labels);
xlabel('# motori'); ylabel('i'); grid on;

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
 hold off

figure('color','white','Name','Em = f(sigma)');
 title('Em = f(\sigma)')
 loglog(  s, Em_max_s,'linewidth',2);
 xlabel('\sigma'); ylabel('Em');  grid on
