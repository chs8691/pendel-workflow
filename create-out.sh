IN="/home/chris/pendel/in"
OUT="/home/chris/pendel/out"

# case in-sensitive  matching
shopt -s nocaseglob

if [ -z "$1" ]
  then echo Missing pendel nr or 'all'. E. g. Call 'import 023'
  exit 0
fi

# Renew complete out
if [ "$1" = "all" ]
  then
    echo Rebuild $OUT... 

    rm $OUT -r
    mkdir $OUT

    echo Copy images...
    find $IN -regex $IN/[0-9][0-9][0-9]/[0-9].*\.jpg | xargs -L1 -I{} cp "{}" $OUT/ 

    echo Rezise images to 1800x1200...
    find $OUT -regex $OUT/[0-9].*\.jpg -printf "%f\n\r" | xargs -L1 -I{} convert -resize 1800x1200 -quality 70%  $OUT/"{}" $OUT/"{}" 

    echo Copy tile images...
    find $IN -regex $IN/[0-9][0-9][0-9]/tile_[0-9].*\.jpg | xargs -L1 -I{} cp "{}" $OUT/ 

    echo Create gps.csv...
    find $OUT -regex $OUT/[0-9].*\.jpg | sort | xargs  exiftool -filename -gpsposition -title -description -n -s -t -S -q -f > $OUT/gps.csv
    
    echo Change file permissions to rw-rw-r--
    chmod 664 $OUT/*

  else
    echo Add "$1" to $OUT
 
    if [ ! -e "$OUT" ]
      then echo Create "$OUT" 
      mkdir "$OUT" 
    fi
    
    for file in $IN/$1/*; do 
      fname=$(basename $file)
      
      pat="^[0-9].*\.jpg"
      if [[ $fname =~ $pat ]];
        then
          echo Copy, convert and chmod $fname...
          cp $file "$OUT"
          convert -resize 1800x1200 -quality 70% $OUT/$fname $OUT/$fname
          chmod 664 $OUT/$fname
      else     
      
        pat="^tile_[0-9].*\.jpg"
        if [[ $fname =~ $pat ]];
          then
            echo Copy and chmod $fname...
            cp $file "$OUT" 
            chmod 664 $OUT/$fname
        fi
      fi 
    done
    
    echo Create and chmod gps.csv...
    find $OUT -regex $OUT/[0-9].*\.jpg | sort | xargs  exiftool -filename -gpsposition -title -description -n -s -t -S -q -f > $OUT/gps.csv
    
    chmod 664 $OUT/gps.csv

fi

echo Done.
