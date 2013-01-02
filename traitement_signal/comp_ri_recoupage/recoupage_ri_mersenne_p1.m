clear all;
close all;

% Script pour repérer le début et la fin de la RI
% RI : Mersenne P1


% On récup la RI
RI_filename = '../mesures/mesure_RI_binaurale_mersenne_recepteurP1/Donnees_temporelles.txt';
data_ri = CTTM_read_txt(RI_filename, 3);
RI_gauche = data_ri(:,3);
RI_droite = data_ri(:,2);

% % on passe à l'énergie
% RI_gauche_energy = [];
% for i=RI_gauche'
% 	i
% 	RI_gauche_energy = [RI_gauche_energy (abs(i))^2];
% end
%
% RI_droite_energy = [];
% for i=RI_droite'
% 	RI_droite_energy = [RI_droite_energy (abs(i))^2];
% end


% subplot(4,1,1);
% plot(normalize(RI_gauche));
% grid on;
% subplot(4,1,2);
% subplot(normalize(RI_gauche_energy));
% grid on;
% subplot(4,1,3);
% plot(normalize(RI_droite));
% grid on;
% subplot(4,1,4);
% subplot(normalize(RI_droite_energy));
% grid on;

% subplot(2,1,1);
plot(normalize(RI_gauche));
grid on;
figure(2);
% subplot(2,1,2);
plot(normalize(RI_droite));
grid on;


