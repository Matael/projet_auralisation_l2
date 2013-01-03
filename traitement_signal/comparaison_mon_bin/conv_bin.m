clear all;
close all;

dossier = '../../mesures/';
fichier = '/Donnees_temporelles.txt';

ratio = .07;

son_anecho = '../reserve_sons/chanson_51k2.wav';

% Récup RI
ris = CTTM_read_txt([dossier 'mesure_RI_binaurale_mersenne_recepteurP1' fichier], 3);
ri_gauche = ris(:,3)*ratio;
ri_droite = ris(:,2)*ratio;

% Récup son anécho
son_anecho = wavread(son_anecho)*ratio;

resultat_g = normalize(fftconv(ri_gauche, son_anecho(:,1)));
resultat_d = normalize(fftconv(ri_droite, son_anecho(:,1)));

result = [resultat_g' ; resultat_d']';

wavwrite(result, 51200, 'conv_bin.wav');

