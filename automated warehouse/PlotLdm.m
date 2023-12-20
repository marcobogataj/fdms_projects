function PlotLdm(ldm, doScale, npt)
% function PlotLdm(ldm, [doScale], [npt])
% Progettazione Funzionale di Sistemi Meccanici e Meccatroncici
% prof. Paolo Righettini
% 
% ldm: struttura che definisce la legge di moto
% parametri:
% ldm: struttura legge di moto
% doscale: 1 scalatura tempo e alzata
% npt: numero dei punti

lw = 3;
if( nargin < 1 )
    error('errore: manca parametro legge di moto');
    return;
end

if( nargin < 2 )
    doScale=1;
end

if( nargin < 3 )
    npt=101;
end


label_x = 'x';
strAdim = 'adimensionale';
yLab{1} = 'G';
yLab{2} = 'F';
yLab{3} = 'f';
vTit{1} = 'spost. %s';
vTit{2} = 'vel. %s';
vTit{3} = 'acc. %s';

if( doScale )
    label_x = sprintf('%s [%s]',ldm.time.label,ldm.time.um);
    strAdim = ' ';
    for k=1:3
        order = k-1;
        if( order == 0 )
            yLab{k} = sprintf('[%s]',ldm.disp.um);
        else
            yLab{k} = sprintf('[%s/%s^%d]',ldm.disp.um,ldm.time.um,order);
        end
    end

end

ldm = EvalLdm(ldm,npt,doScale);

hf=figure;
set(hf,'name',ldm.name);

vClr='rbgcccc';
for k=1:3
    order=k;
    subplot(3,1,order);
    plot(ldm.moto.dim.time,ldm.moto.dim.data{order}.v,vClr(order),'linewidth',lw); grid
    xlabel(label_x);
    title(sprintf(vTit{order},strAdim));
    ylabel(yLab{order});
end


end


