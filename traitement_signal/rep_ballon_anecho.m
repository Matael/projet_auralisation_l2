clear all;
close all,

% Tracé de la réponse temporelle et
% fréquentielle d'un ballon en salle anéchoïque

% récupération des données
filename = '../mesures/seance3_ballon_anecho/ballon_coupe.wav';
file = wavread(filename);
% on vire la valeur moyenne
file = file - mean(file);

Fe = 51200;
len = length(file);

% tracé temporel
subplot(2,1,1);
temps = (0:(len-1))*(1/(Fe));
plot(temps,normalize(file));
xlim([0 0.4]);
grid on;
xlabel('Temps en secondes');
title("Temporel");

% tracé fréquentiel
subplot(2,1,2)
freqs = (1:(len))*(Fe/len);

spectre = fft(file, len);
semilogx(freqs, 20*log10(normalize(abs(spectre))));
grid on;
set(gca,"xminortick","on","xscale","log","xminorgrid","on");
xlim([1 Fe/2]);
ylim([-150 20]);
xlabel("Freqences (en Hz)");
ylabel("Module du spectre (en dB)");
title("Frequentiel");

print('rep_ballon_anecho.png', '-dpng');
