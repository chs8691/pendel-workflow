#!/bin/bash
# Upload files to host
# There must be a file 'credentials' with two line:
# host-username yourusername
# host-password yourtopsecretpassword
IN="/home/chris/pendel/in/$1"
OUT="/home/chris/pendel/out"

# case in-sensitive  matching
shopt -s nocaseglob

if [ -z "$1" ]
  then echo Missing pendel nr.
  exit 0
else
  echo Exporting pendel "$1" to earls5...
fi

# We need the image files from the particular spot...
for file in $IN/*.jpg; do
    files[i]=$OUT/$(basename "$file")
    (( ++i )) 
done

# ...and the gps.csv
files[i]="$OUT/gps.csv"

export SSHPASS=$(grep -Po "(?<=^host-password ).*" credentials)
username=$(grep -Po "(?<=^host-username ).*" credentials)
sshpass -e sftp -oBatchMode=no -b - $username@menkent.uberspace.de << ! 
    cd html/pendel/wp-content/uploads/pendel/ffm
    put "${files[0]}"
    put "${files[1]}"
    put "${files[2]}"
    bye
!

