clear all;
close all;

% On récup la RI {{{1
disp('--> Récupération de la RI');
RI_filename = '../../mesures/mesure_RI_binaurale_mersenne_recepteurP1/Donnees_temporelles.txt';
% valeur recoupage :
start_ri = 143200;
stop_ri = 200000;
ratio = .07;

data_ri = CTTM_read_txt(RI_filename, 3);
ri_gauche_recoupe = data_ri(start_ri:stop_ri,3)*ratio;
ri_droite_recoupe = data_ri(start_ri:stop_ri,2)*ratio;
ri_gauche = data_ri(:,3)*ratio;
ri_droite = data_ri(:,2)*ratio;

% Charger le son anécho {{{1
disp('--> Chargement du son anéchoïque');
son_filename = '../reserve_sons/chanson_51k2.wav';
son = wavread(son_filename);

% Son de référence {{{1
disp('--> Reconstruction du son de référence');
fichier_courant = '../../mesures/rab_mersenne_musique/Donnees_temporelles.txt';
chans = CTTM_read_txt([fichier_courant], 4);
result_ref = [normalize(chans(:,3))' ; normalize(chans(:,2))']';

% Convolution {{{1
disp('--> Convolution');
disp('    + Gauche');
resultat_g = normalize(fftconv(ri_gauche, son(:,1)));
disp('    + Droite');
resultat_d = normalize(fftconv(ri_droite, son(:,1)));
result_conv = [resultat_g' ; resultat_d']';

% Convolution recoupé {{{1
disp('--> Convolution avec RI recoupée');
disp('    + Gauche');
resultat_g_recoupe = normalize(fftconv(ri_gauche_recoupe, son(:,1)));
disp('    + Droite');
resultat_d_recoupe = normalize(fftconv(ri_droite_recoupe, son(:,1)));
result_conv_recoupe = [resultat_g_recoupe' ; resultat_d_recoupe']';

% Ecriture des sons {{{1
disp('--> Ecriture des sons');
wavwrite(result_conv, 51200, ['conv.wav']);
wavwrite(result_conv_recoupe, 51200, ['conv_recoupe.wav']);
wavwrite(result_ref, 51200, ['ref.wav']);

%}}}
