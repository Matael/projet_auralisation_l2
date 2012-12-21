clear all;
close all;

dossier = '../mesures/';
fichier = '/Donnees_temporelles.txt';

ratio = .07;

son_anecho = 'chanson.wav';

% Récup RI
ris = CTTM_read_txt([dossier 'mesure_RI_binaurale_mersenne_recepteurP2_poubelle' fichier], 3);
ri_gauche = ris(:,3)*ratio;
ri_droite = ris(:,2)*ratio;

% Récup son anécho
son_anecho = wavread(son_anecho)*ratio;

resultat_g = fftconv(ri_gauche, son_anecho(:,1));
resultat_d = fftconv(ri_droite, son_anecho(:,2));

result = [resultat_g' ; resultat_d']';

wavwrite(result, 44100, 'conv_poubelle.wav');
