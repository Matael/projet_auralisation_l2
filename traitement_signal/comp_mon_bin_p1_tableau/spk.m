clear all;
close all;

Fe = 51200;

son = 'chanson_51k2';

mono  = wavread(['conv_mono_' son '.wav']);
stereo  = wavread(['conv_' son '.wav']);

st_gauche = stereo(:,1);
st_droite = stereo(:,2);

len_g = length(st_gauche);
len_d = length(st_droite);
len_m = length(mono);

% Calcul des spectres {{{1


% on récupère le signal le plus long
if len_d > mono % aka len_d rulez them all !
	ntfd = len_d;
else
	ntfd = len_m
end

freqs = (1:ntfd)*(Fe/ntfd);

spk_d = fft(st_droite, ntfd);
spk_g = fft(st_gauche, ntfd);
spk_m = fft(mono, ntfd);


% % Première figure {{{1
%
% subplot(3,1,1);
% semilogx(freqs, normalize(20*log10(abs(spk_d))));
% xlim([1 Fe/2]);
% grid on;
% xlabel('Frequences (Hz)');
% ylabel('Module du spectre (en dB)');
% title('Droite');
%
% subplot(3,1,2);
% semilogx(freqs, normalize(20*log10(abs(spk_g))));
% xlim([1 Fe/2]);
% grid on;
% xlabel('Frequences (Hz)');
% ylabel('Module du spectre (en dB)');
% title('Gauche');
%
% subplot(3,1,3);
% semilogx(freqs, normalize(20*log10(abs(spk_m))));
% xlim([1 Fe/2]);
% grid on;
% xlabel('Frequences (Hz)');
% ylabel('Module du spectre (en dB)');
% title('Mono');
%
% % print('spks_ri_recoupe.png', '-dpng');
%
% seconde figure {{{1

figure(2);

subplot(2,1,1);
semilogx(freqs, normalize(20*log10(abs(spk_d))), 'r');
hold on;
semilogx(freqs, normalize(20*log10(abs(spk_m))), 'b');
xlim([1 Fe/2]);
grid on;
legend('droite', 'mono', 'location', 'southwest');
legend('right'); % text à droite
xlabel('Frequences (Hz)');
ylabel('Module du spectre (en dB)');

title('Pleine echelle');


subplot(2,1,2);
semilogx(freqs, normalize(20*log10(abs(spk_g))), 'r');
hold on;
semilogx(freqs, normalize(20*log10(abs(spk_m))), 'b');
xlim([1 Fe/2]);
grid on;
legend('gauche', 'mono', 'location', 'southwest');
legend('right'); % text à droite
xlabel('Frequences (Hz)');
ylabel('Module du spectre (en dB)');

print('spk_res_mono_stereo.png', '-dpng');

% troisieme figure {{{1

figure(3);

subplot(2,1,1);
semilogx(freqs, normalize(20*log10(abs(spk_d))), 'r');
hold on;
semilogx(freqs, normalize(20*log10(abs(spk_m))), 'b');
xlim([150 175]);
ylim([0 1]);
grid on;
legend('droite', 'mono', 'location', 'southwest');
legend('right'); % text à droite
xlabel('Frequences (Hz)');
ylabel('Module du spectre (en dB)');

title('Zoom sur la bande 150-175 Hz');


subplot(2,1,2);
semilogx(freqs, normalize(20*log10(abs(spk_g))), 'r');
hold on;
semilogx(freqs, normalize(20*log10(abs(spk_m))), 'b');
xlim([150 175]);
ylim([0 1]);
grid on;
legend('gauche', 'mono', 'location', 'southwest');
legend('right'); % text à droite
xlabel('Frequences (Hz)');
ylabel('Module du spectre (en dB)');

print('spk_res_mono_stereo_zoom_150_175.png', '-dpng');
