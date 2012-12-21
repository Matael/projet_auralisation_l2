clear all;
close all;

dossier = '../../mesures/';
fichier = '/Donnees_temporelles.txt';

ratio = .07;

% Récup RI
chans = CTTM_read_txt([dossier 'mesure_musique_binaurale_mersenneP1' fichier], 3);

result = [chans(:,2)' ; chans(:,3)']';

wavwrite(result, 44100, 'ref.wav');

