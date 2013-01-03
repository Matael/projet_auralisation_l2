clear all;
close all;

% Calcule H(F) du Haut parleur

dossier = '../mesures/';
fichier = 'Donn�es temporelles.txt';

% r�cup des donn�es
donnees = CTTM_read_txt([dossier 'seance6_rep_freq_hp_1/' fichier], 3);
generateur  = donnees(:,3); % r�f�rence (entr�e)
micro = donnees(:,2); % sortie

% FFT
Fe = 44100;
Ntfd = length(generateur);

spk_gene = normalize(abs(fft(generateur)));
spk_micro = normalize(abs(fft(micro)));
freqs = (1:Ntfd)*(Fe/Ntfd);

% H(F)

% element-wise division
H = spk_micro./spk_gene;
H = normalize(H);

% Plots

subplot(3,1,1); % G�n�
semilogx(freqs, 20*log10(spk_gene));
xlim([0 Fe/2]);
grid on;
title('G�n�rateur');

subplot(3,1,2); % Micro
semilogx(freqs, 20*log10(spk_micro));
xlim([0 Fe/2]);
grid on;
title('Micro');

subplot(3,1,3); % H(F)
semilogx(freqs, 20*log10(H));
xlim([0 Fe/2]);
grid on;
title('H(F) Chaine');
