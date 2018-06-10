#!/bin/bash
SRC="/home/chris/tmpGps"
FOW="/home/chris/egh/photo/02_Progress/pendel"

# case in-sensitive  matching
shopt -s nocaseglob

if [ -z "$1" ]
  then echo Missing pendel nr. E. g. Call 'mvGps.sh 024 025'
  exit 0
fi


shopt -s nullglob
array=($SRC/*.tcx)

i=0
for p in "$@"
  do
    if [ ! -e $FOW/$p/work ]
      then echo Missing $FOW/$p/work
           continue
    fi
    echo "Move $(basename ${array[i]}) to fow $p"
     mv ${array[i]} "$FOW/$p/work/"
    ((++i))
  done
