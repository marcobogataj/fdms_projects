function [E_tot,ED1,ES1] = power_consumption(Wm,t,plot_title,plot_on)
%POWER_CONSUMPTION: Computes and plots power and energy consumption given

for i=1:length(Wm)
    if Wm(i)<0
        Wm_ret(i) = Wm(i);
        Wm_dir(i) = 0;
    else
        Wm_ret(i) = 0;
        Wm_dir(i) = Wm(i);
    end
end

Wm_ret_mean=mean(Wm_ret); %Potenza retrograda MEDIA asse y
Wm_dir_mean=mean(Wm_dir); %Potenza diretta MEDIA asse y

% ENERGIA RETROGRADA immagazzinabile 
ES1=abs(Wm_ret_mean*t(end)); %energia assorbita in un ciclo dal motore [J]

% ENERGIA DIRETTA fornita dal motore
ED1=abs(Wm_dir_mean*t(end)); %energia assorbita in un ciclo dal motore [J]

%Bilancio ENERGIA
E_tot = ED1-ES1;% energia fornita al netto dell'energia immagazzinabile

if (plot_on == 1)
    figure('color','white');
    hold on;grid on;
    %plot(t,Wm_ret,'g','linewidth',2);  
    b=area(t,Wm_dir);
    b(1).FaceColor = [0 0 1];  % Colore dell'area 1 (RGB)
    a=area(t,Wm_ret);
    a(1).FaceColor = [0 1 0];  % Colore dell'area 1 (RGB)
    
    yline(Wm_ret_mean,'g--')
    yline(Wm_dir_mean,'b--')
    xlabel('t');
    ylabel('Watt')
    legend('Potenza diretta','Potenza retrograda','Potenza retrograda MEDIA','Potenza diretta MEDIA')
    title("Potenza al motore" + plot_title);
    
    
    % ENERGIA RETROGRADA immagazzinabile 
    disp(['Energia immagazzinabile dal motore ES1 = ', num2str(ES1/3600),'  Wh'] );
    
    % ENERGIA DIRETTA fornita dal motore
    disp(['Energia fornita dal motore ED1 = ', num2str(ED1/3600),'  Wh'] );
    
    %Bilancio ENERGIA
    disp(['Energia netta dal motore E_tot = ', num2str(E_tot/3600),'  Wh'] );
end

end

