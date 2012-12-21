clear all;
close all;

dossier = '../../mesures/';
fichier = '/Donnees_temporelles.txt';

ratio = .07;

% quelques sons
fichiers = {'mesure_claquement_mains_binaurale_mersenneP1';
'mesure_cle_binaurale_mersenneP1';
'mesure_musique_binaurale_mersenneP1'};

sons = {'handclaps_51k2';
'cles_51k2';
'chanson_51k2'};
RI = 'mesure_RI_binaurale_mersenne_recepteurP1';

% charger la RI
ris = CTTM_read_txt([dossier RI fichier], 3);
ri_gauche = ris(:,3)*ratio;
ri_droite = ris(:,2)*ratio;

% faire les calculs et la convo pour chaque son
% -> convo
% -> reference

len = length(sons);
count = 1;

while count<=len
	son = char(sons(count));
	fichier_courant = char(fichiers(count));
	disp(['Processing: ' son]);
	% on recrée la référence
	disp('--> Referece sound reconstruction');
	chans = CTTM_read_txt([dossier fichier_courant  fichier], 3);
	result = [chans(:,3)' ; chans(:,2)']';
	wavwrite(result, 51200, ['ref_' son '.wav']);

	% on convolue
	disp('--> Convolution RI*Sound');
	son_anecho = wavread(['../reserve_sons/' son '.wav']);
	resultat_g = normalize(fftconv(ri_gauche, son_anecho(:,1)));
	resultat_d = normalize(fftconv(ri_droite, son_anecho(:,1)));
	result = [resultat_g' ; resultat_d']';
	wavwrite(result, 51200, ['conv_' son '.wav']);

	count = count +1;
end
