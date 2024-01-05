function [motori] = DB_Mot2()
%data base motori prova
%matte_main
%% MOTORI BONFIGLIOLI
% motori(1)=struct('Codice','BMD_{102-5.6}','Jm',3.4e-04,'CN',5.6,'Cm_max',2.5*5.6,'nMAX',6000);
% 
% motori(2)=struct('Codice','BMD_{102-5.8}','Jm',3.4e-04,'CN',5.8,'Cm_max',2.5*5.8,'nMAX',5500);
% 
% motori(3)=struct('Codice','BMD_{102-6}','Jm',3.4e-04,'CN',6,'Cm_max',2.5*6,'nMAX',4500);
% 
% motori(4)=struct('Codice','BMD_{102-6.7}','Jm',3.4e-04,'CN',6.7,'Cm_max',2.5*6.7,'nMAX',3000);
% 
% motori(5)=struct('Codice','BMD_{102-7}','Jm',3.4e-04,'CN',7,'Cm_max',2.5*7,'nMAX',1600);
% 
% motori(6)=struct('Codice','BMD_{102-6.5}','Jm',4.7e-04,'CN',6.5,'Cm_max',2.5*6.5,'nMAX',6000);
% 
% motori(7)=struct('Codice','BMD_{102-6.9}','Jm',4.7e-04,'CN',6.9,'Cm_max',2.5*6.9,'nMAX',5500);

motori(1)=struct('Codice','BMD_{102-7.7}','Jm',4.7e-04,'CN',7.7,'Cm_max',2.5*7.7,'nMAX',4500);

motori(2)=struct('Codice','BMD_{102-8.5}','Jm',4.7e-04,'CN',8.5,'Cm_max',2.5*8.5,'nMAX',3000);

motori(3)=struct('Codice','BMD_{102-9.2}','Jm',4.7e-04,'CN',9.2,'Cm_max',2.5*9.2,'nMAX',1600);

motori(4)=struct('Codice','BMD_{102-6.5}','Jm',17.6e-04,'CN',6.5,'Cm_max',2.5*6.5,'nMAX',6000);

motori(5)=struct('Codice','BMD_{102-15}','Jm',17.6e-04,'CN',15,'Cm_max',2.5*15,'nMAX',5500);

motori(6)=struct('Codice','BMD_{102-17}','Jm',17.6e-04,'CN',17,'Cm_max',2.5*17,'nMAX',4500);
% 
% motori(7)=struct('Codice','BMD_{102-19.2}','Jm',17.6e-04,'CN',19.2,'Cm_max',2.5*19.2,'nMAX',3000);
% 
%  motori(8)=struct('Codice','BMD_{102-20.7}','Jm',17.6e-04,'CN',20.7,'Cm_max',2.5*20.7,'nMAX',1600);
% % MOTORI ASSE ORIZZONTALE
% motori(1)=struct('Codice','BMD_{82-3.15}','Jm',1.7e-04,'CN',3.15,'Cm_max',2.5*3.15,'nMAX',6000);
% 
% motori(2)=struct('Codice','BMD_{82-3.3}','Jm',1.7e-04,'CN',3.3,'Cm_max',2.5*3.3,'nMAX',5500);
% 
% motori(3)=struct('Codice','BMD_{82-3.55}','Jm',1.7e-04,'CN',3.55,'Cm_max',2.5*3.55,'nMAX',4500);
% 
% motori(4)=struct('Codice','BMD_{82-3.8}','Jm',1.7e-04,'CN',3.8,'Cm_max',2.5*3.8,'nMAX',3000);
% 
% motori(5)=struct('Codice','BMD_{82-4.2}','Jm',1.7e-04,'CN',4.2,'Cm_max',2.5*4.2,'nMAX',1600);
% 
% motori(6)=struct('Codice','BMD_{102-2.8}','Jm',1.9e-04,'CN',2.8,'Cm_max',2.5*2.8,'nMAX',6000);
% 
% motori(7)=struct('Codice','BMD_{102-2.9}','Jm',1.9e-04,'CN',2.9,'Cm_max',2.5*2.9,'nMAX',5500);
% 
% motori(8)=struct('Codice','BMD_{102-3.1}','Jm',1.9e-04,'CN',3.1,'Cm_max',2.5*3.1,'nMAX',4500);
% 
% motori(9)=struct('Codice','BMD_{102-3.4}','Jm',1.9e-04,'CN',3.4,'Cm_max',2.5*3.4,'nMAX',3000);
% 
% motori(10)=struct('Codice','BMD_{102-3.7}','Jm',1.9e-04,'CN',3.7,'Cm_max',2.5*3.7,'nMAX',1600);
% 
% motori(11)=struct('Codice','BMD_{82-2.5}','Jm',1.4e-04,'CN',2.5,'Cm_max',2.5*2.5,'nMAX',6000);
% 
% motori(12)=struct('Codice','BMD_{82-2.6}','Jm',1.4e-04,'CN',2.6,'Cm_max',2.5*2.6,'nMAX',5500);
% 
% motori(13)=struct('Codice','BMD_{82-2.8}','Jm',1.4e-04,'CN',2.8,'Cm_max',2.5*2.8,'nMAX',4500);
% 
% motori(14)=struct('Codice','BMD_{82-3}','Jm',1.4e-04,'CN',3,'Cm_max',2.5*3,'nMAX',3000);
% 
% motori(15)=struct('Codice','BMD_{82-3.15}','Jm',1.4e-04,'CN',3.15,'Cm_max',2.5*3.15,'nMAX',1600);
% 
% motori(16)=struct('Codice','BMD_{65-1.8}','Jm',0.6e-04,'CN',1.8,'Cm_max',2.5*1.8,'nMAX',6000);
% 
% motori(17)=struct('Codice','BMD_{65-1.85}','Jm',0.6e-04,'CN',1.85,'Cm_max',2.5*1.85,'nMAX',5500);
% 
% motori(18)=struct('Codice','BMD_{65-1.95}','Jm',0.6e-04,'CN',1.95,'Cm_max',2.5*1.95,'nMAX',4500);
% 
% motori(19)=struct('Codice','BMD_{65-2.05}','Jm',0.6e-04,'CN',2.05,'Cm_max',2.5*2.05,'nMAX',3000);
% 
% motori(20)=struct('Codice','BMD_{65-2.12}','Jm',0.6e-04,'CN',2.12,'Cm_max',2.5*2.12,'nMAX',1600);
% 
% motori(21)=struct('Codice','BMD_{65-1.45}','Jm',0.4e-04,'CN',1.45,'Cm_max',2.5*1.45,'nMAX',6000);
% 
% motori(22)=struct('Codice','BMD_{65-1.48}','Jm',0.4e-04,'CN',1.48,'Cm_max',2.5*1.48,'nMAX',5500);
% 
% motori(23)=struct('Codice','BMD_{65-1.52}','Jm',0.4e-04,'CN',1.52,'Cm_max',2.5*1.52,'nMAX',4500);
% 
% motori(24)=struct('Codice','BMD_{65-1.6}','Jm',0.4e-04,'CN',1.6,'Cm_max',2.5*1.6,'nMAX',3000);
% 
% motori(25)=struct('Codice','BMD_{65-1.65}','Jm',0.4e-04,'CN',1.65,'Cm_max',2.5*1.65,'nMAX',1600);
% 
% motori(26)=struct('Codice','BMD_{118-3.9}','Jm',4.5e-04,'CN',3.9,'Cm_max',2.5*3.9,'nMAX',6000);
% 
% motori(27)=struct('Codice','BMD_{118-4.1}','Jm',4.5e-04,'CN',4.1,'Cm_max',2.5*4.1,'nMAX',5500);
% 
% motori(28)=struct('Codice','BMD_{118-4.6}','Jm',4.5e-04,'CN',4.6,'Cm_max',2.5*4.6,'nMAX',4500);