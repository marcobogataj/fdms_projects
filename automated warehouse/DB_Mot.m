function [motori] = DB_Mot()
%data base motori prova

motori(1) = struct('Codice','b61.1.30', 'CN', 1.2, 'Jm',  9e-5, 'nMAX', 3000,'Tmax',3.9);
motori(2) = struct('Codice','b61.1.60', 'CN', 1.05, 'Jm', 9e-5, 'nMAX', 6000,'Tmax',3.9);

motori(3) = struct('Codice','b61.2.30', 'CN', 2.2, 'Jm',  1.65e-4, 'nMAX', 3000,'Tmax',7.5);
motori(4) = struct('Codice','b61.2.60', 'CN', 1.8, 'Jm',  1.65e-4, 'nMAX', 6000,'Tmax',7.5);

motori(5) = struct('Codice','b61.3.30', 'CN', 3.1, 'Jm',  2.35e-4, 'nMAX',  3000,'Tmax',10.8);
motori(6) = struct('Codice','b61.3.60', 'CN', 2.3, 'Jm',  2.35e-4, 'nMAX', 6000,'Tmax',10.8);
