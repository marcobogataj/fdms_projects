function [Wm] = EvalPowerHorizontal(mlc_x,t)
%EVALPOWER
    %load data
    Do= 0.32; %[m] diametro della ruota
    Ro= Do/2;
    fv= 0.009; %coefficiente attrito volvente
    Pco= 8000; %[N] peso carrello orizzontale vuoto  
    P= 8000; %[N] peso massimo trasportabile
    g= 9.81;

    %load ldm
    %x = mlc.moto.data{1}.v;
    xp = mlc_x.moto.data{2}.v;
    xpp = mlc_x.moto.data{3}.v;
    tx = mlc_x.moto.time;

    %compute power
    wc=xp/Ro; %rad/s
    wpc=xpp/Ro; %rad/s^2
    
    for k=1:length(t)
        if(t(k)<tx) %fase di CARICO
        
        Ca(k)=(P+Pco)*fv*Ro*sign(wc(k));
        Ci(k)=wpc(k)*(((P+Pco)/g)*Ro^2);
    
        end
        if (t(k)>tx) %fase di SCARICO
        
        Ca(k)=(Pco)*fv*Ro*sign(wc(k));
        Ci(k)=wpc(k)*(((Pco)/g)*Ro^2);
        end
       
    end

    Cu=Ca+Ci;

    %Famiglia di trasmissioni scelta: ESP 100/2
    T.Codice='ESP 100/2';
    T.eta=1;%caso ideale
    T.i=50;%rapporto di riduzione
    T.JT=2.8e-5; %momento inerzia kgm^2 lato motore
    T.M2=250; %Nm coppia massima all'uscita
    
    Cm=(Cu/(T.eta*T.i))+wpc*T.i*(Jm+T.JT); %coppia motore di verifica
    Wm=Cm.*wc*T.i;%Potenza motore di verifica
        

end

