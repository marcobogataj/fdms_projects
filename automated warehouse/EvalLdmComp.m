function [lc]=EvalLdmComp(lc,npt)
% function [lc]=EvalLdmComp(lc,[npt])
% Progettazione Funzionale di Sistemi Meccanici e Meccatroncici
% prof. Paolo Righettini
% 
% valuta ldm composta su npt punti
% lc: struttura dati ldm composta
% npt: numero di punti a cui campionare

if( nargin < 1 )
    error('errore: manca parametro legge di moto');
end
if( nargin < 2 )
    npt=101;
end

%numero leggi di moto
nl=length(lc.vldm);
T = 0;
for k=1:nl
   T = T + lc.vldm{k}.ta;
end

dt=(T/(npt-1));


vt=zeros(1,npt-1);
% y = vt;
% yp=y;
% ypp=y;

time = 0;
prevTime = 0;
prevH = 0;
j=1;

lc.moto.data = cell(3,1);
for k=1:3
    lc.moto.data{k}.v = zeros(1,npt-1);
end

for k=1:nl
    ta = lc.vldm{k}.ta ;
    h = lc.vldm{k}.h;
    while( time <= (prevTime + ta) )
        locTime = time - prevTime;
        x = locTime/ta;
        [G,F,f] = feval(lc.vldm{k}.file, lc.vldm{k}.par, x);
        
        lc.moto.data{1}.v(j) = G*h + prevH;
        lc.moto.data{2}.v(j) = F*h/ta;
        lc.moto.data{3}.v(j) = f*h/ta^2;
%         y(j) = G*h + prevH;
%         yp(j) = F*h/ta;
%         ypp(j) = f*h/ta^2;
        vt(j) = time;
        time = time + dt;
        j = j+1;
    end

    prevTime = prevTime + ta;
    prevH = prevH + h;    
    
end


% lc.moto.y = y;
% lc.moto.yp = yp;
% lc.moto.ypp = ypp;
lc.moto.time = vt;


