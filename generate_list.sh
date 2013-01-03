#/bin/bash

ls --group-directories-first --directory mesures/* | head -47 | cut -d / -f 2 > liste_mesures.txt

