function [G,F,f] = ConstSym(par,x)
% function [ G, F, f ] = CostSimm( par, x )
% Progettazione Funzionale di Sistemi Meccanici e Meccatroncici
% prof. Paolo Righettini
% 
% Descrive la legge di moto ad accelerazione costante tagliata in forma adimensionale 
%
% ritorna il valore di accelerazione, velelocita'  spostameto adimensionali
% calcolati al tempo adimensionale x
% par: struttura dati dei parametri per la configurazione della ldm 
% x: tempo adimensionale a cui calcolare la ldm. 0 <= x <= 1
%
% G, F, f: Posizione, velocità, accelerazione adimensionale calcolati

%%intervallo ad accelerazione costante. Deve essere <= 1/2, >= 0

xv = par.xv;

Ca=1/(xv*(1-xv));
Cv = 1/(1-xv);

if( x>= 0 && x < xv)
    f = Ca;
    F = Ca*x;
    G= Ca*x^2/2;
elseif(x >= xv && x < (1-xv) )
    f = 0;
    F = Cv;
    G= Ca*xv^2/2 + Cv*(x-xv);
elseif( x >= (1-xv) && x <= 1 )
    f = -Ca;
    xloc = x-(1-xv);
    F = Cv -Ca*xloc;
    G= Ca*xv^2/2 + Cv*(1-2*xv) + Cv*xloc -Ca*xloc^2/2;
else
    f=0;
    F=0;
    G=0;
end
            
            