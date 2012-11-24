clear all;
close all;

% prefixe
dossier = '../mesures/';
% suffixe
fichier = 'Donnees_temporelles_Voie1.wav';

Ntfd = 2^14;
Fe = 44100;

% axe des frequences
freqs = (0:(Ntfd-1))*(Fe/Ntfd);

% ouvrir les fichiers
ri1 = wavread([dossier 'seance2_reverb1/' fichier]);
ri1 = ri1 - mean(ri1);
ri2 = wavread([dossier 'seance2_reverb2/' fichier]);
ri2 = ri2 - mean(ri2);

% couper un le signal le plus long
%
% la perte n'est pas importante :
% il y a toujours du "blanc" à la fin
if length(ri1) > length(ri2)
	ri1 = ri1(1:length(ri2),:);
elseif length(ri2) > length(ri1)
	ri2 = ri2(1:length(ri1),:);
endif




% crea du fichier image
print('compare_ri_mono.png', '-dpng');
