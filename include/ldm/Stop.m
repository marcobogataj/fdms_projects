function [G,F,f] = Stop(par,x)
% function [G,F,f] = Stop(par,x)
% Progettazione Funzionale di Sistemi Meccanici e Meccatroncici
% prof. Paolo Righettini
% 
% Descrive la legge di moto che impone spostamento nullo in forma adimensionale 
%
% ritorna il valore di accelerazione, velelocita'  spostameto adimensionali
% calcolati al tempo adimensionale x
% par: nessun parametro per configurarla
% x: tempo adimensionale a cui calcolare la ldm. 0 <= x <= 1
%
% G, F, f: Posizione, velocità, accelerazione adimensionale calcolati

G=1;
F=0;
f=0;
