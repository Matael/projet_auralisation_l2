clear all;
close all;

dossier = '../mesures/';
fichier = '/Donnees_temporelles.txt';

ratio = .07;

son_anecho = 'handclaps_44k1.wav';

% Récup RI
ris = CTTM_read_txt([dossier 'mesure_reverb_ri_tete_cote_droite' fichier], 3);
ri_gauche = ris(:,3)*ratio;
ri_droite = ris(:,2)*ratio;

% Récup son anécho
son_anecho = wavread(son_anecho)*ratio;

resultat_g = fftconv(ri_gauche, son_anecho);
resultat_d = fftconv(ri_droite, son_anecho);

result = [resultat_g' ; resultat_d']';

wavwrite(result, 44100, 'conv_bin2_cote_droite.wav');
