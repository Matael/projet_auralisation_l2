clear all;
close all;

dossier = '../../mesures/';
fichier = '/Donnees_temporelles.txt';

ratio = .07;

son_anecho = '../reserve_sons/chanson_51k2.wav';

% Récup RI
ris = CTTM_read_txt([dossier 'mesure_RI_monorale_mersenne_recepteurP1' fichier], 2);
ri = ris(:,2)*ratio;

% Récup son anécho
son_anecho = wavread(son_anecho)*ratio;

resultat_g = normalize(fftconv(ri, son_anecho(:,1)));
resultat_d = normalize(fftconv(ri, son_anecho(:,1)));

result = [resultat_g' ; resultat_d']';

wavwrite(result, 51200, 'conv_mon.wav');

