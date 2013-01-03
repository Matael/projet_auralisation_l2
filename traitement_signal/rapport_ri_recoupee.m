clear all;
close all;

RI_data = CTTM_read_txt('../mesures/mesure_RI_binaurale_mersenne_recepteurP1/Donnees_temporelles.txt', 3);
Fe = 51200;

% RI non recoupée {{{1
subplot(1,4,[1 3]);

plot(RI_data(:,1), normalize(RI_data(:,2)));
xlabel('Temps (s)');
ylabel('Amplitude (normalisee)');
ylim([-1, 1]);
grid on;
title('a)');

subplot(1,4,4);

start = 143000;
stop = 200000;

temps = (0:(stop-start))*(1/Fe);
plot(temps, normalize(RI_data(start:stop,2)));
xlabel('Temps (s)');
ylabel('Amplitude (normalisee)');
ylim([-1, 1]);
grid on;
title('b)');



print('../rapport/ri_non_recoupee.png', '-dpng');
