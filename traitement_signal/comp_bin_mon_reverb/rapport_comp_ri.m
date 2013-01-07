clear all;
close all;

dossier = '../../mesures/';
fichier = '/Donnees_temporelles.txt';

ratio = .07;
Fe = 51200;

son_fn = 'handclaps_51k2';

RI_mono = 'seance2_reverb1';

disp('Fetching MRIR');
ri_mono = CTTM_read_txt([dossier RI_mono fichier], 2);
ri_mono = ri_mono(:,2);

subplot(2,2,1); % RI
temps = (0:length(ri_mono)-1)*(1/Fe);
plot(temps, ri_mono, 'b');
title('a)');
xlabel('Temps (s)');


subplot(2,2,2); % son
son = wavread(['../reserve_sons/' son_fn '.wav']);
son = son(:,1);
temps = (0:length(son)-1)*(1/Fe);
plot(temps, son);
xlabel('Temps (s)');
title('b)');

subplot(2,2,[3 4]);
final = wavread(['conv_mono_' son_fn '.wav']);
final = final(:,1);
temps = (0:length(final)-1)*(1/Fe);
plot(temps, final, 'b');
xlabel('Temps (s)');
title('c)');

print('rapport_comp_reverb.png', '-dpng');
