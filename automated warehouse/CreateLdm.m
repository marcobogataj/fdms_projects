function [ ldm ] = CreateLdm(fileName, par  )
% function [ ldm ] = CreateLdm(fileName, par  )
% Progettazione Funzionale di Sistemi Meccanici e Meccatroncici
% prof. Paolo Righettini
% 
% Crea la struttura dati con i campi necessari alla descrizione di una
% legge di moto in forma adimensionale.
% Viene inizialmente fissata una legge di moto ad accelerazione costante
% tagliata
%
% campi inseriti nella struttura dati:
% fileName: contiene il nome del file matlab (.m) che definisce la legge di moto 
% par: struttura dati con tutti i parametri necessari alla definizione
%       della legge di moto (dipende dalla legge di moto)



if( nargin < 1 )
    fileName = 'ConstSym';
    par.xv = 0.2;
end
if( nargin == 1 )
    ldm = [];
    error('specificare tutti i parametri!');
end

ldm.par = par; % parametri di configurazione della legge di moto
ldm.ta = 1;
ldm.h = 1;
%nome del file.m (senza estensione)%descrivente la legge di moto
ldm.file = fileName;

ldm.name = 'movimento numero 1'; % descrizione del movimento

%questi parametri permottono di assegnare la dimensione alla ldm
%nelle condizioni iniziali, sono assegnati i valori adimensionali
time.um='s';
time.label='time';
%ora alzate
disp.um='m';
disp.label='spostamento';

ldm.disp = disp;
ldm.time = time;

end

