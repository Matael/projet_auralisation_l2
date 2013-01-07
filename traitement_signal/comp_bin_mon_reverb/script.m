clear all;
close all;

suffixe = '_droite';

dossier = '../../mesures/';
fichier = '/Donnees_temporelles.txt';

ratio = .07;
Fe = 51200;

% quelques sons
fichiers = {'','handclaps_51k2';
'','cles_51k2';
'','chanson_51k2'};

RI = 'mesure_reverb_ri_tete';
RI_mono = 'seance2_reverb1';

% charger la RI
disp('Fetching BRIR');
ris = CTTM_read_txt([dossier RI fichier], 3);
ri_gauche = ris(:,3)*ratio;
ri_droite = ris(:,2)*ratio;

disp('Fetching MRIR');
ri_mono = CTTM_read_txt([dossier RI_mono fichier], 2);
ri_mono = ri_mono(:,2)*ratio;


% faire les calculs et la convo pour chaque son
% -> convo
% -> reference

len = length(fichiers);
count = 1;

disp(['File to process : ' num2str(len)]);
while count<=len
	son = char(fichiers(count,2));
	fichier_courant = char(fichiers(count,1));
	disp(['Processing: ' son]);

	% % on recrée la référence
	% disp('--> Referece sound reconstruction');
	% chans = CTTM_read_txt([dossier fichier_courant  fichier], 3);
	% result_ref = [normalize(chans(:,3))' ; normalize(chans(:,2))']';
	% wavwrite(result_ref, 51200, ['ref_' son '.wav']);

	% on convolue
	disp('--> Convolution RI*Sound');
	son_anecho = wavread(['../reserve_sons/' son '.wav']);
	resultat_g = normalize(fftconv(ri_gauche, son_anecho(:,1)));
	resultat_d = normalize(fftconv(ri_droite, son_anecho(:,1)));
	result_conv = [resultat_g' ; resultat_d']';
	wavwrite(result_conv, 51200, ['conv_' son suffixe '.wav']);

	% on convolue
	disp('--> Convolution RI_mono*Sound');
	resultat_g = normalize(fftconv(ri_mono, son_anecho(:,1)));
	resultat_d = normalize(fftconv(ri_mono, son_anecho(:,1)));
	result_conv = [resultat_g' ; resultat_d']';
	wavwrite(result_conv, 51200, ['conv_mono_' son suffixe '.wav']);

	% on génère un graphe en temporel
	% close all;
	% disp('--> generating time graph');
	% subplot(4,1,1);
	% plot(result_ref(:,1), 'b');
	% ylim([-1.5 1.5]);
	% grid on;
	% title(['[REF] Oreille Gauche -- ' son]);
	% subplot(4,1,2);
	% plot(result_conv(:,1), 'r');
	% ylim([-1.5 1.5]);
	% grid on;
	% title(['[CONV] Oreille Gauche -- ' son]);
	% subplot(4,1,3);
	% plot(result_ref(:,2), 'b');
	% ylim([-1.5 1.5]);
	% grid on;
	% title(['[REF] Oreille Droite -- ' son]);
	% subplot(4,1,4);
	% plot(result_conv(:,2), 'r');
	% ylim([-1.5 1.5]);
	% grid on;
	% title(['[CONV] Oreille Droite -- ' son]);
	% print(['temporel_' son '.png'],'-dpng');

	count = count +1;
end
