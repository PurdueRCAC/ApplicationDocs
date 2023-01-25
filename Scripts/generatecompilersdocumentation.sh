#! /bin/bash
# This script generates documentation files for aocc, gcc, and intel from /opt/spack/modulefiles/Core under the Compilers folder and then updates index.rst
# Example Usage: ./generatecompilersdocumentation.sh

declare -a listofmissingfiles=(
[0]=aocc
[1]=gcc
[2]=intel
)

current_dir="$PWD" # save current directory 
cd ../ # go up one directory
repo_path="$PWD" # assign path to repo_path
cd $current_dir # cd back to current directory

for filename in ${listofmissingfiles[@]}; do 
    echo ""
    echo $filename

    inputfolder="/opt/spack/modulefiles/Core/$filename/"
    # echo "input folder: "$inputfolder

    filenamesarray=`ls $inputfolder*.lua`
    for eachfile in $filenamesarray
    do
        inputpath=$eachfile #This assumes last file name in alphabetical order is the file to parse
    done
    echo "input path: "$inputpath

    containername=$(echo $inputpath | awk -F/ '{print $(NF-1)}')

    outputfile="$repo_path/Compilers/$containername.rst"
    echo "output file: "$outputfile

    inputpathcontent=$(<$inputpath)

    mkdir -p $repo_path/Compilers

    echo ".. _backbone-label:" > $outputfile
    echo "" >> $outputfile
    echo "${containername^}" >> $outputfile
    echo "==============================" >> $outputfile
    echo "" >> $outputfile

    if grep -q -i description "$inputpath"; then
        echo "Description was found" # Description was found
        echo "Description" >> $outputfile
        echo "~~~~~~~~" >> $outputfile
        description=$(cat $inputpath | grep -i "description")
        echo "${description##*:}" | sed -e 's/)//g' -e 's/(//g' -e 's/"//g' -e "s/'//g" -e 's/]//g' -e 's/^[ \t]*//;s/[ \t]*$//' >> $outputfile
        echo "" >> $outputfile
    else
        echo "description not found"   
    fi

    echo "Versions" >> $outputfile
    echo "~~~~~~~~" >> $outputfile
    for eachfile in $filenamesarray
    do
        echo -n "- " >> $outputfile
        eachfile2=$eachfile
        eachfile=${eachfile::-4}
        echo "$eachfile" | sed 's:.*/::' >> $outputfile
    done
    echo "" >> $outputfile
    echo "Module" >> $outputfile
    echo "~~~~~~~~" >> $outputfile
    echo "You can load the modules by::" >> $outputfile
    echo "" >> $outputfile
    echo "    module load $containername" >> $outputfile
    echo "" >> $outputfile

done

# Update index.rst

indexfile="/$repo_path/index.rst"
cd $repo_path

subfoldersarray=`ls -d */`

sed -i '/.. toctree::/,$d' $indexfile

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for eachfolder in $subfoldersarray
do
    if [ "$eachfolder" != "Scripts/" ] && [ "$eachfolder" != "images/" ]; then
        echo "each folder : $eachfolder"
        echo ".. toctree::" >> $indexfile
        eachfolderwithspaces="${eachfolder//_/ }"
        echo "   :caption: "${eachfolderwithspaces::-1}"" >> $indexfile
        echo "   :titlesonly:" >> $indexfile
        echo "   " >> $indexfile
        sourcefolder="$repo_path/$eachfolder"

        echo "source folder : $sourcefolder"
        filenamesarray=`ls "$sourcefolder"`
        for eachfile in $filenamesarray
        do
            eachfile=${eachfile::-4}
            echo "   $eachfolder""$eachfile" >> $indexfile
        done
        echo "" >> $indexfile 
    fi
done
IFS=$SAVEIFS

cd "$current_dir"