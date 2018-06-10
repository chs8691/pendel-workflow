#!/bin/bash
SRC="/home/chris/egh/photo/02_Progress/pendel"
DST="/home/chris/pendel/in"

# case in-sensitive  matching

shopt -s nocaseglob
if [ -z "$1" ]
  then echo Missing pendel nr. E. g. Call 'import 023'
  exit 0
else
  echo Importing pendel "$1"...
fi
if [ ! -e $DST/$1 ]
  then echo Create $DST/$1
  mkdir $DST/$1
fi

# Copy images from final
i=0 
for file in $SRC/$1/final/*.jpg; do  
    imgs[i]="$file"
    (( ++i )) 
done
for file in "${imgs[@]}"; do  
  cp "$file" "$DST/$1" 
done

# Copy tcx file from work directory
for file in $SRC/$1/work/*.tcx; do  
    tcxs[i]="$file"
    (( ++i )) 
done
for file in "${tcxs[@]}"; do  
  cp "$file" "$DST/$1" 
done

# Copy tile file from work directory 
for file in $SRC/$1/work/tile_*.jpg; do  
    tiles[i]="$file"
    (( ++i )) 
done
for file in "${tiles[@]}"; do  
  cp "$file" "$DST/$1"  
done

# List dir
echo Imported into "$DST/$1":
ls "$DST/$1"
