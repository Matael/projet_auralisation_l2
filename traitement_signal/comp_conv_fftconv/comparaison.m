clear all;
close all;

% prefixe
dossier = '../../mesures/';
% suffixe
fichier = 'Donnees_temporelles.txt';
Ntfd = 2^14;
Fe = 44100;

start = 225800;
stop = 357500;

target_start = 278700;
target_stop = 401000;

file = CTTM_read_txt([dossier 'seance2_reverb1/' fichier], 2);
ri = file(start:stop,2);
ri = ri - mean(ri);
ri = ri*0.5;

target_sound = wavread('../handclaps_44k1.wav');
target_sound = target_sound(target_start:target_stop);

% convolution
result_conv = conv(ri,target_sound);
result_fftconv = fftconv(ri,target_sound);

% Comparaison
comp = sqrt(result_conv.^2 - result_fftconv.^2);

subplot(3,1,1);
plot(result_conv);
plot('Conv');

subplot(3,1,2);
plot(result_fftconv);
plot('FFT Conv');

subplot(3,1,3);
plot(comp);
title('Comparaison');
