clear all;
close all;

res = wavread('conv_handclaps_51k2_droite.wav');
gauche = res(:,1);
droite = res(:,2);

temps = (0:length(droite)-1)*(1/51200);

plot(temps, 1.2*gauche, 'b');
hold on;
plot(temps, droite, 'r');

xlabel('Temps (s)');
legend('Oreille gauche', 'Oreille droite', 'location', 'southeast');

print('rapport_droite.png', '-dpng');

