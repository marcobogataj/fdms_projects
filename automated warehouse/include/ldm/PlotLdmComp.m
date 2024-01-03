function PlotLdmComp(lc,npt)
%function PlotLdmComp(lc,[npt])
% Progettazione Funzionale di Sistemi Meccanici e Meccatroncici
% prof. Paolo Righettini
% 
% ldm: struttura che definisce la legge di moto
% parametri:
% ldm: struttura legge di moto
% npt: numero dei punti
lw = 3;
if( nargin < 1 )
    error('errore: manca parametro legge di moto');
end

if( nargin < 2 )
    npt = 1000;
end

label_x = 'x';
strAdim = 'adimensionale';
yLab{1} = 'G';
yLab{2} = 'F';
yLab{3} = 'f';
vTit{1} = 'spost. %s';
vTit{2} = 'vel. %s';
vTit{3} = 'acc. %s';

doScale=1;
if( doScale )
    label_x = sprintf('%s [%s]',lc.time.label,lc.time.um);
    strAdim = ' ';
    for k=1:3
        order = k-1;
        if( order == 0 )
            yLab{k} = sprintf('[%s]',lc.disp.um);
        else
            yLab{k} = sprintf('[%s/%s^%d]',lc.disp.um,lc.time.um,order);
        end
    end

end

[lc]=EvalLdmComp(lc,npt);

hf=figure;
set(hf,'name',lc.name);

vClr='rbgcccc';
for k=1:3
    order=k;
    subplot(3,1,order);
    plot(lc.moto.time,lc.moto.data{order}.v,vClr(order),'linewidth',lw); grid on
    xlabel(label_x);
    title(sprintf(vTit{order},strAdim));
    ylabel(yLab{order});
end


