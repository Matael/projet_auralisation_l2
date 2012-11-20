clear all;
close all;

% Tracé des RI mesurées le 16/11

dossier = '../../mesures/';

Fe = 44100;

% premiere et seconde réponse

subplot(1,2,1);
file = wavread([dossier 'seance2_reverb1/Donnees_temporelles_Voie1.wav']);
file = file - mean(file);

spectre = fft(file, length(file));
freqs = (0:(length(file)-1))*(Fe/length(file));

plot(freqs, 20*log10(abs(spectre)));
xlim([0 Fe/2]);
title('Premiere mesure de RI monaurale')
ylabel('Module du spectre (en dB)');
xlabel('Frequence (en Hz)');

subplot(1,2,2);
file = wavread([dossier 'seance2_reverb2/Donnees_temporelles_Voie1.wav']);
file = file - mean(file);

spectre = fft(file, length(file));
freqs = (0:(length(file)-1))*(Fe/length(file));

plot(freqs, 20*log10(abs(spectre)));
xlim([0 Fe/2]);
title('Seconde mesure de RI monaurale')
ylabel('Module du spectre (en dB)');
xlabel('Frequence (en Hz)');

print('ris_monaurales.png', '-dpng');

close all;

% réponse pour les oreilles gauches et droite

%% gauche

subplot(1,2,1);
file = wavread([dossier 'seance2_reverb_tete1/Donnees_temporelles_Voie1.wav']);
file = file - mean(file);

spectre = fft(file, length(file));
freqs = (0:(length(file)-1))*(Fe/length(file));

plot(freqs, 20*log10(abs(spectre)));
xlim([0 Fe/2]);
title("RI pour l'oreille gauche");
ylabel('Module du spectre (en dB)');
xlabel('Frequence (en Hz)');

subplot(1,2,2);
file = wavread([dossier 'seance2_reverb_tete1/Donnees_temporelles_Voie2.wav']);
file = file - mean(file);

spectre = fft(file, length(file));
freqs = (0:(length(file)-1))*(Fe/length(file));

plot(freqs, 20*log10(abs(spectre)));
xlim([0 Fe/2]);
title("RI pour l'oreille droite")
ylabel('Module du spectre (en dB)');
xlabel('Frequence (en Hz)');

print('ri_binaurale.png', '-dpng');
