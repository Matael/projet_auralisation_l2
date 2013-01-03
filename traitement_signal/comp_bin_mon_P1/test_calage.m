clear all;
close all;

dossier = '../../mesures/';
fichier = '/Donnees_temporelles.txt';

% suffixe pour les graphes générés
suffixe = '';

% Nombre de points pour le second graphe
len = 0;

ratio = .07;
Fe = 51200;
nb_colonnes = 4;
start = 50000;
stop = 200001;
backward = 000;

% quelques sons
fichier_courant = 'rab_mersenne_musique';
son = 'chanson_51k2';
RI = 'mesure_RI_binaurale_mersenne_recepteurP1';

% charger la RI
disp('--> Fetching BRIR');
ris = CTTM_read_txt([dossier RI fichier], 3);
ri_gauche = ris(:,3)*ratio;
ri_droite = ris(:,2)*ratio;

% faire les calculs et la convo pour chaque son
% -> convo
% -> reference

disp(['[Processing: ' son ']']);

% on recrée la référence
disp('--> Reference sound reconstruction');
chans = CTTM_read_txt([dossier fichier_courant  fichier], nb_colonnes);
result_ref = [normalize(chans(:,3))' ; normalize(chans(:,2))']';
wavwrite(result_ref, 51200, ['ref_' son '.wav']);

% on convolue
disp('--> Convolution RI*Sound');
son_anecho = wavread(['../reserve_sons/' son '.wav']);
resultat_g = normalize(fftconv(ri_gauche, son_anecho(:,1)));
resultat_d = normalize(fftconv(ri_droite, son_anecho(:,1)));
result_conv = [resultat_g' ; resultat_d']';
wavwrite(result_conv, 51200, ['conv_' son '.wav']);

% calage temporel
disp('--> Synchronising sounds');

% disp('+ computing distances for reference');
% dist_ref = [];
% for i=(2:length(result_ref(:,1)))
% 	dist_ref = [dist_ref abs(result_ref(i,1) - result_ref(i-1,1))];
% end

disp('+ looking for signal energy per band of 100 points');
disp('	(will just look at the first quarter of the signal)');

% axe des temps
seconds = chans(start:stop,1);

% idem pour l'énergie
seconds_energy = [];
means = [];
for i=(start:100:stop)
	means = [means mean(result_ref(i:i+100))];
	seconds_energy = [seconds_energy seconds(i-start+1)];
end
ref_energy = abs(means).^2;
means = [];
for i=(start:100:stop)
	means = [means mean(result_conv(i:i+100))];
end
conv_energy = abs(means).^2;

% Generate a plot and save it
disp('+ Generating energy report plot');
subplot(4,1,1);
plot(seconds, result_ref(start:stop,1));
grid on;
title([num2str(stop) ' first points of reconstructed ref sound']);

subplot(4,1,2);
plot(seconds_energy, ref_energy);
grid on;
title('Same sequence energy-wise');

subplot(4,1,3);
plot(seconds, result_conv(start:stop,1));
grid on;
title([num2str(stop) ' first points of convoluted sound']);

subplot(4,1,4);
plot(seconds_energy, conv_energy);
grid on;
title('Same sequence energy-wise');

% save graph
print(['calage_energy_' suffixe '.png'], '-dpng');

disp('+ Computing shifting to apply');

mean_energy_conv = mean(conv_energy(1:300));
i = 1;
while i<length(conv_energy)
	if conv_energy(i) > mean_energy_conv*7
		start_conv = start + (i-1)*100 - backward;
		% rapport au fait qu'on analyse sur une bande start:stop par pas de 100 points
		% le + 500 est liés au fait qu'on veuille prendre pour début le 500 ème point avant
		% le pic à 2.5*moyenne
		break;
	end
	i++;
end
% idem pour le son de référence
mean_energy_ref = mean(ref_energy(2:300));
i = 1;
while i<length(ref_energy)
	if ref_energy(i) > mean_energy_ref*3
		start_ref = start + (i-1)*100 - backward;
		break;
	end
	i++;
end

% if start_ref>start_conv
% 	result_ref = result_ref((start_ref+start_ref-start_conv):end,1);
% 	result_conv = result_conv((start_conv):end,1);
% else
% 	result_conv = result_conv((start_conv+start_conv-start_ref):end,1);
% 	result_ref = result_ref((start_ref):end,1);
% end

result_ref = result_ref(start_ref:end, :);
result_conv = result_conv(start_conv:end, :);

if len==0
	disp(['    >> length undefined. Computing final length']);
	if length(result_ref(:,1))>length(result_conv(:,1))
		len = length(result_conv(:,1))/2;
	else
		len = length(result_ref(:,1))/2;
	end
else
	disp(['    >> length defined by user.']);
end

% On affiche tout ça :
disp(['    Chosen start for convoluted sound : ' num2str(start_conv)]);
disp(['    Chosen start for reference sound : ' num2str(start_ref)]);
disp(['    Chosen length for both sounds : ' num2str(len)]);


disp('+ Generating temporaly synchronized signals plot');
figure(2);

seconds = (0:len-1)*(1/Fe);
plot(seconds, result_ref(1:len,1));
hold on;
plot(seconds, result_conv(1:len,1),'r');
grid on;
title([num2str(len) ' first points of both sound']);
print(['calage_final_' suffixe '.png'], '-dpng');
