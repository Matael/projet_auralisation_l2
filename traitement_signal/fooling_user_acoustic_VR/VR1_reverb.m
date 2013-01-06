clear all;
close all;

% Globales {{{1

RI_f_fn = 'mesure_reverb_ri_tete'; % filename RI face
RI_d_fn = 'mesure_reverb_ri_tete_cote_droite'; % filename RI droite

RI_f_start = 173507;
RI_f_stop = 255999;

RI_d_start = 98374;
RI_d_stop = 177675;

dossier = '../../mesures/';
fichier = '/Donnees_temporelles.txt';

Fe = 51200;

ratio = .07;

son_fn = 'handclaps_51k2';

result_fn = 'VR1_reverb.wav';

% Récup des RI et fenetrage {{{1

RI_f = CTTM_read_txt([dossier RI_f_fn fichier], 3);
RI_f = RI_f(
		RI_f_start:RI_f_stop,
		2:3);

RI_d = CTTM_read_txt([dossier RI_d_fn fichier], 3);
RI_d = RI_d(
		RI_d_start:RI_d_stop,
		2:3);

% Son anecho {{{1

son = wavread(['../reserve_sons/' son_fn '.wav']);
son = son(:,1);


% Combinaison des RI {{{1

len_d = length(RI_d);
len_f = length(RI_f);
delta = len_d-len_f;

if delta > 0
	RI_f = [RI_f ; zeros(delta,2)];
elseif delta < 0
	RI_d = [RI_d ; zeros(-delta,2)];
end

RI = RI_f + RI_d;

% Convolution {{{1

res_d = fftconv(RI(:,1), son);
res_g = fftconv(RI(:,2), son);

res = [
	(normalize(res_g)*ratio)';
	(normalize(res_d)*ratio)']';

wavwrite(res, Fe, result_fn);
