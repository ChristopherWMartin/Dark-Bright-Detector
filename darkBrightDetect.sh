#!/bin/bash

command -v convert >/dev/null 2>&1 || { echo "This script requires 'ImageMagick'. Aborting." >&2; exit 1; }
command -v bc >/dev/null 2>&1 || { echo "This script requires 'bc'. Aborting." >&2; exit 1; }

bold=$(tput bold)
normal=$(tput sgr0)

definedThreshold=0.8
for file in *.jpg; do

    read width height < <(identify -format '%w %h' $file)
    totalPixels=$((width * height))
    acceptableThreshold=$(echo "scale=0; ($definedThreshold * $totalPixels)/1" | bc)

    read white black < <(convert $file -format "%[fx:mean*w*h] %[fx:(1-mean)*w*h]" info:)

    black=$(echo "scale=0; $black/1" | bc)
    white=$(echo "scale=0; $white/1" | bc)

	  if (("$black" > "$acceptableThreshold")) ;
	then
	    echo "${bold}removing $file - too dark${normal}"
      #rm $file
	else
		if (("$white" > "$acceptableThreshold")) ;
		then
		    echo "${bold}removing $file - too bright${normal}"
        #rm $file
		fi
	fi
  echo "$file - black: $black, white: $white, threshhold: $acceptableThreshold"
done
