function lc = CreateLdmComp(nel)
% function lc = CreateLdmComp(nel)
% Progettazione Funzionale di Sistemi Meccanici e Meccatroncici
% prof. Paolo Righettini
% 
% crea struttura dati ldm composta
% nel: numero ldm elementari

if( nargin < 1 )
    nel=1;
end
lc.vldm = cell(nel,1);
for k=1:nel
    lc.vldm{k} = CreateLdm();
end

lc.name = 'ldm composta';

%questi parametri permottono di assegnare la dimensione alla ldm
%nelle condizioni iniziali, sono assegnati i valori adimensionali
time.um='s';
time.label='time';
%ora alzate
disp.um='m';
disp.label='spostamento';

lc.time = time;
lc.disp = disp;

% lc.labelTime = 's';
% lc.labelAlzata = 'm';
