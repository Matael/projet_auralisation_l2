clear all;
close all;

Fe = 51200;

conv_recoupe = wavread('conv_recoupe.wav');
conv_sans = wavread('conv.wav');

% Calcul des spectres {{{1
ntfd = length(conv_sans(:,1));
% ntfd = 2^15;
freqs = (1:ntfd)*(Fe/ntfd);

spk_recoupe = fft(conv_recoupe(:,1),ntfd);
spk_sans = fft(conv_sans(:,1), ntfd);


% Première figure {{{1

subplot(2,1,1);
semilogx(freqs, normalize(20*log10(abs(spk_sans))));
xlim([1 Fe/2]);
grid on;
xlabel('Frequences (Hz)');
ylabel('Module du spectre (en dB)');
title('a)');

subplot(2,1,2);
semilogx(freqs, normalize(20*log10(abs(spk_recoupe))));
xlim([1 Fe/2]);
grid on;
xlabel('Frequences (Hz)');
ylabel('Module du spectre (en dB)');

title('b)');

% print('spks_ri_recoupe.png', '-dpng');

% Seconde Figure {{{1

figure(2);

semilogx(freqs, normalize(20*log10(abs(spk_recoupe))), 'r');
hold on;
semilogx(freqs, normalize(20*log10(abs(spk_sans))));
xlim([1 Fe/2]);
grid on;
legend('avec fenetrage', 'sans fenetrage', 'location', 'southwest');
legend('right'); % text à droite
xlabel('Frequences (Hz)');
ylabel('Module du spectre (en dB)');

% print('spks_ri_recoupe_superimposed.png', '-dpng');
