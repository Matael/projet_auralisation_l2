clear all;
close all;

% prefixe
dossier = '../mesures/';
% suffixe
fichier = 'Donnees_temporelles.txt';
Ntfd = 2^14;
Fe = 44100;

start = 273250;
stop = 378620;

ri1 = load([dossier 'seance2_reverb1/' fichier]);
ri1 = ri1(:,2);
ri1 = ri1 - mean(ri1);
ri1 = ri1(start:stop,:);
ri1 = ri1*.75;

target_sound = wavread('handclaps_44k1.wav');
target_sound = target_sound*.75;

% convolution
result = conv(ri1,target_sound);

disp('AYE FINI !');

wavwrite(result, Fe, 'conv_mono1_2.wav');
