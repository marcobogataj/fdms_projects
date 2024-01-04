function OttProduttivita(mot,G,nTMax) 
%% Plot di produttività max vs lunghezza prodotto

Rp= 0.045;%[m] radius of working heads
Jr= 11.5e-3;%[kg*m^2] moment of inertia of the drums, gears included, reflected to the trasmission's output
theta_zero= 30; %[°] working angle

%legge ad accelerazione costante 1/3 1/3 1/3
Cv= 1.5;
Ca= 4.5;

Cm_max=mot.Cm_max;
CN=mot.CN;
Jm=mot.Jm;
nMAX=min(nTMax,mot.nMAX);
wMAX=nMAX*2*pi/60;

for n = 1:4 % iterate for number of working heads
    disp(['OPTIMIZE FOR n° working heads = ' , num2str(n)])
    figure
    sgtitle(['n° working heads = ', num2str(n)])

    for L = 0.05:0.01:0.25 %iterate for different product lengths

        P = 0; % productivity initialization

        % initialize loop conditions to enter the loop
        MC = 2;
        Cm_vmax = 0;
        w_vmax = 0;

        while MC > 1 && Cm_max > Cm_vmax && wMAX > w_vmax
            P = P + 1; % increase productivity by one [pcs/min]
            v0= (P*L)/60; %line speed [m/s]
            T= L/v0; %cycle time [s]
            Lp= (2*pi*Rp)/n; %peripheral distance between adiacent working heads

            ts= (theta_zero*(pi/180)*Rp)/v0; %tempo di lavoro
            h= Lp-L; %alzata
            ta= T-ts; % variable speed time

            vr_max= v0+Cv*(h/ta);
            ar_max= Ca*(h/ta^2);
            ar_rms=sqrt((2/3)*(ta/T))*ar_max;

            nxp = [v0    v0     vr_max      vr_max       v0    ]; % velocità per punti
            nt  = [0      ts    ts+ta/3    ts+2*ta/3      ts+ta]; % vettore tempo

            t=linspace(nt(1),nt(end),1000);
            xp =interp1(nt,nxp, t);

            w = xp./Rp; %velocità angolare

            w_max=max(abs(w)); %rad/s
            w_rms=rms(w);

            vr_max= v0+Cv*(h/ta);
            ar_max= Ca*(h/ta^2);
            ar_rms=sqrt((2/3)*(ta/T))*ar_max;

            nxpp = [0       0      ar_max           ar_max       0                   0         -ar_max                -ar_max  ]; % accelerazione per punti
            nt  =   [0      ts      ts+0.000001      ts+ta/3       ts+ta/3+0.000001   ts+2*ta/3    ts+2*ta/3+0.000001      ts+ta]; % vettore tempo

            t=linspace(nt(1),nt(end),1000);
            xpp =interp1(nt,nxpp, t);

            wp= xpp./Rp;% accelerazione angolare
            wp_max=max(abs(wp)); %rad/s^2
            wp_rms=rms(wp); %rad/s^2

            %coppia
            Cu=Jr.*wp; % coppia lato utilizzatore
            Cu_rms=rms(Cu);
            Cu_max=max(Cu);      

            Cm_v=(Cu/(G.eta*G.i))+wp*G.i*(Jm+G.JT); %coppia motore di verifica
            Cm_vrms=rms(Cm_v);
            
            % calcolo variabili di verifica per ottenere Pmax
            w_vmax = w_max*G.i;
            Cm_vmax=max(abs(Cm_v));
            MC=CN/Cm_vrms; %determinare margine di coppia

           
        end

        subplot(1,3,1)
        plot(L,P,'xb','LineWidth',4);
        xlabel('Product length [m]')
        ylabel('Pmax [pcs/min]')
        title('Max productivty vs product length');
        grid on
        hold on;

        subplot(1,3,2)
        plot(L,ts,'xr','LineWidth',4);
        xlabel('Product length [m]')
        ylabel('t_s [s]')
        title('Welding time at max productivity');
        grid on
        hold on;
        
        if (rem(L,0.05) == 0)
            subplot(1,3,3)
            plot(t, xp,'linewidth',2,'DisplayName', ['L=',num2str(L),' Pmax=',num2str(P)])
            grid on
            title('velocità periferica')
            xlabel('t [s]');
            ylabel('xp [m/s]');
            hold on;
            legend('show')

        end     
    end

end


end


