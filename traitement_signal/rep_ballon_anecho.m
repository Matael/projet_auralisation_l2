clear all;
close all,

% Tracé de la réponse temporelle et
% fréquentielle d'un ballon en salle anéchoïque

% récupération des données
filename = '../mesures/seance3_ballon_anecho/ballon_coupe.wav';
file = wavread(filename);
% on vire la valeur moyenne
file = file - mean(file);

Fe = 44100;
len = length(file);

% tracé temporel
subplot(2,1,1);
temps = (0:(len-1))*(1/(Fe*len));
plot(temps,file);
grid on;
title("Temporel");

% tracé fréquentiel
subplot(2,1,2)
freqs = (0:(len-1))*(Fe/len);

spectre = fft(file, len);
plot(freqs, 20*log10(abs(spectre)));
grid on;
xlim([0 Fe/2]);
ylim([-50 50]);
xlabel("Freqences (en Hz)");
ylabel("Module du spectre (en dB)");
title("Frequentiel");

print('rep_ballon_anecho.png', '-dpng');
