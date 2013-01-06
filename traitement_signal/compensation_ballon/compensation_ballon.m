clear all;
close all;

dossier = '../../mesures/';
fichier = '/Donnees_temporelles.txt';

Fe = 51200;

% Start/Stop Ballon
ballon_anecho_fn = 'seance3_ballon_anecho';
start_ballon = 86000;
stop_ballon = 145500;

% RI
RI_fn = 'seance2_reverb1';
RI_colonnes = 2;
RI_start = 271440;
RI_stop = 395100;


% Récupération du ballon {{{1
disp('--> Récup du ballon');
rep_ballon = CTTM_read_txt([dossier ballon_anecho_fn fichier], 2);
rep_ballon = rep_ballon(start_ballon:stop_ballon,2);

% Récup d'une RI {{{1
disp(['--> Récup RI : ' RI_fn ]);

RI = CTTM_read_txt([dossier RI_fn fichier], RI_colonnes);
RI = RI(RI_start:RI_stop,2);


% Calcul des spectres {{{1
disp('--> FFT time');
ntfd = length(RI);
freqs = (1:ntfd)*(Fe/ntfd);

spk_RI = normalize(fft(RI, ntfd));
spk_ballon = normalize(fft(rep_ballon, ntfd));

disp('--> Figure de contrôle');

subplot(2,1,1);
semilogx(freqs, 20*log10(normalize(abs(spk_RI))));
xlim([1 Fe/2]);
grid on;
set(gca, 'xminorgrid', 'on');
title('Module du spectre de la RI (en dB)');

subplot(2,1,2);
semilogx(freqs, 20*log10(normalize(abs(spk_ballon))));
xlim([1 Fe/2]);
grid on;
set(gca, 'xminorgrid', 'on');
title('Module du spectre du ballon en salle semi-anecho (en dB)')

print('controle_spks.png', '-dpng');

% Déconv {{{1
close all;

disp('--> Déconvolution');
spk_res = normalize(spk_RI./spk_ballon);

res = ifft(spk_res, length(spk_res)/2);

disp('--> Second Graphe');

subplot(2,1,1);
temps = (0:length(res)-1)*(1/Fe);
plot(temps, normalize(res));
grid on;
xlabel('Temps en secondes');
title('RI finale');

subplot(2,1,2);
semilogx(freqs, 20*log10(normalize(abs(spk_res))));
grid on;
set(gca, 'xminorgrid', 'on');
xlim([1 Fe/2]);
title('Module du spectre de la RI finale (en dB)');

print('spk_RI_finale.png', '-dpng');

disp('--> Ecriture du wav');

wavwrite(res, Fe, 'test_deconV1.WAV');
