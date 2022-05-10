#!/bin/sh

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#   Programmer Name: Sheikh   
#   Description: Argument validation
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~    


if [ -z "$1" -o -z "$2" ]
then
    echo -e "Usage: $0 $1 $2"
    #exit 1
else
input_file="$1"
output_file="$2"
echo "$input_file $output_file"
fi
echo "done"


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#  Descritpion: Checking if a file already exist in the directory
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


if [ -f "$1" ]
then
    input_file="$1"
    echo "$input_file Yes file exist"
    #exit 1
else
echo "$1 file doesn't exist"
echo "yes"
fi


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#  Descritpion: Checking if a md5sum exist in a file
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

md=$(md5sum "$input_file")
gre=$(grep -c "$md" checksum.log)

echo "$gre"
if [ "$gre" -eq 1 ]
then
#exit 1
echo "ami exit hochchi"
fi
md5sum "$input_file" >> checksum.log
echo "Checksum has been changed as files were changed"



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#  Descritpion: Zipping Multiple files inside a single zip folder into 10 files each zip
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

zipsplit -n 265000 archive.zip



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#  Descritpion: Zipping Documents with account number 10 files each 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ls | grep .pdf > lsoutput.txt
i=1
m=1

while read line; do
    echo $line
    grep -B 11 -A 2 "$line" RWCU_NOTICES_DLC_1.xml >> Index_"$m".xml
    if [ $i -eq 10 ]; then
        head -n 5 RWCU_NOTICES_DLC_1.xml > temp.xml
        cat Index_"$m".xml >> temp.xml
        cat temp.xml > Index_"$m".xml
        tail -n 2 RWCU_NOTICES_DLC_1.xml >> Index_"$m".xml
        zip -u archive_"$m".zip "$line"
        zip -u archive_"$m".zip Index_"$m".xml
        m=$((m + 1))
        i=$((1))
    else
        zip -u archive_"$m".zip "$line"
        i=$((i + 1))
    fi
done < lsoutput.txt

head -n 5 RWCU_NOTICES_DLC_1.xml > temp.xml
cat Index_"$m".xml >> temp.xml
cat temp.xml > Index_"$m".xml
tail -n 2 RWCU_NOTICES_DLC_1.xml >> Index_"$m".xml
zip -u archive_"$m".zip Index_"$m".xml




