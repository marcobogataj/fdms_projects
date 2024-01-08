function [Wm] = EvalPowerHorizontal(mlc)
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
    xp = mlc.moto.data{2}.v;
    xpp = mlc.moto.data{3}.v;
    tx = mlc.moto.time;

    %compute power
    wc=xp/Ro; %rad/s
    wpc=xpp/Ro; %rad/s^2
    
    for k=1:length(ty)
        if(tx(k)<t_12h)
        
        Ca(k)=(P+Pco)*fv*Ro*sign(wc(k));
        Ci(k)=wpc(k)*(((P+Pco)/g)*Ro^2);
    
        end
        if (tx(k)>t_12h)&&(tx(k)<2*t_12h+10)
        
        Ca(k)=(Pco)*fv*Ro*sign(wc(k));
        Ci(k)=wpc(k)*(((Pco)/g)*Ro^2);
        end
        if (tx(k)>2*t_12h+10)
        
        Ca(k)=(P+Pco)*fv*Ro*sign(wc(k));
        Ci(k)=wpc(k)*(((P+Pco)/g)*Ro^2);
        
        end
    end

    Cu=Ca+Ci;

    Wm = 0;

end

