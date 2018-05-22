# Upload files to earls5
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

#for file in "${files[@]}"; do
#  echo "$file"
# done
#echo "${files[0]}"
#echo "${files[1]}"
#echo "${files[2]}"
#exit 0
export SSHPASS=topsecretpassword
sshpass -e sftp -oBatchMode=no -b - user@host << ! 
    cd html/pendel/wp-content/uploads/pendel/ffm
    put "${files[0]}"
    put "${files[1]}"
    put "${files[2]}"
    bye
!

