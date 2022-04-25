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
exit 1
fi
md5sum "$input_file" > checksum.log
echo "Checksum has been changed as files were changed"
