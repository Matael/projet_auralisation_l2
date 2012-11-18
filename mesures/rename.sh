#!/bin/bash

for i in *
do
	if [[ -d $i ]]; then
		mv $i/Donn{ées\ ,ees_}temporelles_Voie1.wav
		mv $i/Donn{ées\ ,ees_}temporelles_Voie2.wav
		mv $i/Donn{ées\ ,ees_}temporelles.txt
		mv $i/Donn{ées\ ,ees_}temporelles.uff58
		mv $i/Configuration{\ ,_}Mesure.txt
	fi
done
