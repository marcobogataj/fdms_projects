function ldm = EvalLdm(ldm, npt, doScale)
% function ldm = EvalLdm(ldm, [npt], [doScale])
% Progettazione Funzionale di Sistemi Meccanici e Meccatroncici
% prof. Paolo Righettini
% 
% ldm: struttura che definisce la legge di moto
% parametri:
% ldm: struttura legge di moto
% npt: numero dei punti
% doScale: 1 scala ldm nel dominio del tempo
% doScale: 0 ldm in forma adimensionale

if( nargin < 1 )
    error('errore: manca parametro legge di moto');
end

if( nargin < 2 )
    npt=101;
end


if( nargin < 3 )
   doScale=0;
end

if (doScale == 1)
    scale.coeff(1) = ldm.h;
    scale.coeff(2) = ldm.h/ldm.ta;
    scale.coeff(3) = ldm.h/(ldm.ta^2);
    scale.time = ldm.ta;
else
    scale.coeff(1) = 1;
    scale.coeff(2) = 1;
    scale.coeff(3) = 1;
    scale.time = 1;
end

step=(1/(npt-1)); %intervalli

%vettore con i valori del tempo adimensionale a cui calcolare
%la ldm
x=[0:step:1];
n=length(x);

%vAd = cell(3,1);
ldm.moto.adim.data = cell(3,1);
for k=1:3
    %vAd{k}.v = zeros(1,n);
    ldm.moto.adim.data{k}.v = zeros(1,n);
end

for k=1:n
    %[vG(k),vF(k),vf(k)] = feval(ldm.file, ldm.par, x(k));
    %[vAd{1}.v(k), vAd{2}.v(k),vAd{3}.v(k),] = feval(ldm.file, ldm.par, x(k));
    [ldm.moto.adim.data{1}.v(k), ldm.moto.adim.data{2}.v(k),ldm.moto.adim.data{3}.v(k)] ...
        = feval(ldm.file, ldm.par, x(k));
end

ldm.moto.adim.x = x; %vettore del tempo adimensionale

%in questo modo salvo sempre ....
%doScale=1;
ldm.moto.dim.data = cell(3,1);
for k=1:3
    %calcolo il movimento in coordinate dimensionali
    %moltiplicando quello adimensionale per i fattori di scala
    ldm.moto.dim.data{k}.v = ldm.moto.adim.data{k}.v.*scale.coeff(k);
end
%vettore del tempo dimensionale
ldm.moto.dim.time = x.*scale.time;



