clear all;
close all;

% prefixe
dossier = '../mesures/';
% suffixe
fichier = 'Donnees_temporelles.txt';
Ntfd = 2^14;
Fe = 44100;

start = 225800;
stop = 357500;

target_start = 278700;
target_stop = 401000;

file = load([dossier 'seance2_reverb_tete1/' fichier]);
ri_gauche = file(start:stop,2);
ri_gauche = ri_gauche - mean(ri_gauche);
ri_gauche = ri_gauche*0.5;

ri_droite = file(start:stop,2);
ri_droite = ri_droite - mean(ri_droite);
ri_droite = ri_droite*0.5;

target_sound = wavread('handclaps_44k1.wav');

% convolution
result_g = conv(ri_gauche,target_sound);
result_d = conv(ri_droite,target_sound);

result = [result_g' ; result_d' ];
result = result';

disp('AYE FINI !');

wavwrite(result*0.1, Fe, 'conv_bin1_1.wav');
