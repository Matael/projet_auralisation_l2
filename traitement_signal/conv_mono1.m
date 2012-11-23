clear all;
close all;

% prefixe
dossier = '../mesures/';
% suffixe
fichier = 'Donnees_temporelles_Voie1.wav';

Ntfd = 2^14;
Fe = 44100;

% début et fin de la réponse (à proprement parler)
start = 273250;
stop = 378620;

% charger la réponse impulsionnelle et la "retailler"
ri1 = wavread([dossier 'seance2_reverb1/' fichier]);
ri1 = ri1 - mean(ri1);
ri1 = ri1(start:stop,:);

% charger un son anécho
target_sound = wavread('handclaps_44k1.wav');

% convolution
result = fftconv(ri1,target_sound);
result

wavwrite(result, Fe, "conv_mono1.wav");
