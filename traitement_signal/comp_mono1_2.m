clear all;
close all;

dossier = '../mesures/';
fichier = '/Donnees_temporelles.txt';

ri1 = CTTM_read_txt([dossier 'seance2_reverb1' fichier], 2);
ri1 = ri1(:,2) - mean(ri1(:,2));
len1 = length(ri1);
ri2 = CTTM_read_txt([dossier 'seance2_reverb2' fichier], 2);
ri2 = ri2(:,2) - mean(ri2(:,2));
len2 = length(ri2);

if len1 < len2
    ri2 = ri2(1:len1);
    Ntfd = len1;
elseif len1 > len2
    ri2 = ri2(1:len1);
    Ntfd = len2;
else
    Ntfd = len1;
end

spectre1 = normalize(abs(fft(ri1,Ntfd)));
spectre2 = normalize(abs(fft(ri2,Ntfd)));

Fe = 44100;
freqs = (0:(Ntfd-1))*(Fe/Ntfd);

subplot(3,1,1);
plot(freqs, 20*log10(spectre1));
title('|FFT(mono1)|');
xlabel('Frequence en Hz');
ylabel('Amplitude en dB');

subplot(3,1,2);
plot(freqs, 20*log10(spectre2));
title('|FFT(mono2)|');
xlabel('Frequence en Hz');
ylabel('Amplitude en dB');

subplot(3,1,3);
plot(freqs, sqrt((20*log10(spectre1))^2 - (20*log10(spectre2))^2));
title('Comparaison');
xlabel('Frequence en Hz');

print('compare_mono1_2.png', '-dpng');