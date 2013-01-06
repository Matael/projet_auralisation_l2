clear all;
close all;

% globales {{{1

bin_fn = 'conv_chanson_51k2.wav';
start_bin = 177058;

mon_fn = 'conv_mono_chanson_51k2.wav';
start_mon = 107546;

% nombre de points à afficher
forward = 1000;
Fe = 51200;

% récup des sons {{{1
% mon
mon = wavread(mon_fn);

% bin
bin = wavread(bin_fn);

% Graphe 1 {{{1

len_b = length(bin(:,1))-start_bin;
len_m = length(mon(:,1))-start_mon;
if len_m > len_b
	temps = (0:len_m)*(1/Fe);
	bin = [bin ; zeros(len_m-len_b,2)];
else
	temps = (0:len_b)*(1/Fe);
	mon = [mon ; zeros(len_m-len_b,2)];
end

subplot(2,1,1);
plot(temps, normalize(bin(start_bin:end,1)), 'r');
hold on;
plot(temps, normalize(mon(start_mon:end,1)), 'b');
xlabel('Temps (s)');
grid on;
legend('Binaural', 'Monaural', 'location', 'southeast');
title('Oreille Gauche');

subplot(2,1,2);
plot(temps, normalize(bin(start_bin:end,2)), 'r');
hold on;
plot(temps, normalize(mon(start_mon:end,2)), 'b');
xlabel('Temps (s)');
grid on;
legend('Binaural', 'Monaural', 'location', 'southeast');
title('Oreille Droite');

print('temporel_cale.png', '-dpng');


% Graphe 2 {{{1
figure(2);
mon = mon(start_mon:start_mon+forward,2);
bin = bin(start_bin:start_bin+forward,2);
temps = (0:forward)*(1/Fe);

plot(temps, mon, 'b');
hold on;
plot(temps, bin, 'r');

grid on;
legend('monaural', 'binaural', 'location', 'southeast');
title("Tracé temporel des signaux pour l'oreille gauche");
xlabel('Temps (s)');

print(['temporel_' num2str(forward) '_points_cale.png'], '-dpng');
