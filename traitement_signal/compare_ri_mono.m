clear all;
close all;

% prefixe
dossier = '../mesures/';
% suffixe
fichier = 'Donnees_temporelles_Voie1.wav';

Ntfd = 2^14;
Fe = 44100;

% axe des frequences
freqs = (0:(Ntfd-1))*(Fe/Ntfd);

% calculer le premier spectre
ri1 = wavread([dossier 'seance2_reverb1/' fichier]);
ri1 = ri1 - mean(ri1);

spectre_ri1 = fft(ri1, Ntfd);


% calculer le second
ri2 = wavread([dossier 'seance2_reverb2/' fichier]);
ri2 = ri2 - mean(ri2);

spectre_ri2 = fft(ri2, Ntfd);

% difference des spectres
spectre_diff = spectre_ri1-spectre_ri2;

% différence complète
subplot(2,1,1);
plot(freqs, 20*log10(abs(spectre_diff)), 'r');
hold on;
plot(freqs, 20*log10(abs(spectre_ri1))); % reference
xlim([0 Fe/2]);
grid on;
title("Difference entre les spectres [0 Fe/2] Hz");
xlabel("Frequences (en Hz)");
ylabel("Amplitude de la difference (en dB)");


% différence 0-2500
subplot(2,1,2);
plot(freqs, 20*log10(abs(spectre_diff)), 'r');
hold on;
plot(freqs, 20*log10(abs(spectre_ri1))); % reference
xlim([0 2500]);
grid on;
title("Difference entre les spectres [0 2500] Hz");
xlabel("Frequences (en Hz)");
ylabel("Amplitude de la difference (en dB)");

% crea du fichier image
print('compare_ri_mono.png', '-dpng');
