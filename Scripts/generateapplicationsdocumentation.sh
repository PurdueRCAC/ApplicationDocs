#! /bin/bash
# This script generates documentation files under the Applications folder and then updates index.rst
# Example Usage: ./generateapplicationsdocumentation.sh

current_dir="$PWD" # save current directory 
cd ../ # go up one directory
repo_path="$PWD" # assign path to repo_path
cd $current_dir # cd back to current directory

function generateLuaFiles() {
    for filename in ${listofmissingfiles[@]}; do 
        echo ""
        echo $filename

        inputfolder="$luasource/$filename/"
        echo "input folder: "$inputfolder

        filenamesarray=`ls $inputfolder*.lua`
        for eachfile in $filenamesarray
        do
            inputpath=$eachfile #This assumes last file name in alphabetical order is the file to parse
        done
        echo "input path: "$inputpath

        containername=$(echo $inputpath | awk -F/ '{print $(NF-1)}')

        outputfile="$repo_path/Applications/$containername.rst"
        echo "output file: "$outputfile

        inputpathcontent=$(<$inputpath)

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
}

function generateListOfMissingFiles() {
    diff -x '*.lua' -q $applicationsfolder $luasource | grep "Only in /opt/" > tempfile.txt
    awk 'NF{ print $NF }' tempfile.txt > listofmissingfiles.txt
    rm tempfile.txt
    readarray -t listofmissingfiles < listofmissingfiles.txt
}

applicationsfolder="$repo_path/Applications/"

# Generate Lua files from clang
luasource="/opt/spack/modulefiles/clang/9.0.0"
generateListOfMissingFiles
generateLuaFiles

# Generate Lua files from gcc
luasource="/opt/spack/modulefiles/gcc/10.2.0"
generateListOfMissingFiles
generateLuaFiles

# Generate Lua files from intel
luasource="/opt/spack/modulefiles/intel/19.0.5"
generateListOfMissingFiles
generateLuaFiles

# Generate Lua files from intel-mpi
luasource="/opt/spack/modulefiles/intel-mpi/2019.5.281-3fyzsi3/intel/19.0.5"
generateListOfMissingFiles
generateLuaFiles

# Generate Lua files from ml-toolkit
luasource="/opt/spack/modulefiles/ml-toolkit/conda-2020.11-py38/cpu/modules/ml-toolkit-cpu"
generateListOfMissingFiles
generateLuaFiles

# Generate Lua files from openmpi
luasource="/opt/spack/modulefiles/openmpi/4.1.3-xy4bdtp/intel/19.0.5"
generateListOfMissingFiles
generateLuaFiles

# Generate Lua files from utilities
luasource="/opt/spack/modulefiles/utilities"
generateListOfMissingFiles
generateLuaFiles

# Generate Lua files from Core
luasource="/opt/spack/modulefiles/Core"
generateListOfMissingFiles
generateLuaFiles

# Remove all files that had default.lua in their subfolder in Core
for dir in /opt/spack/modulefiles/Core/*/
do
    if [ -f "$dir/default.lua" ];
    then
        echo ""
        filename=$(echo $dir | awk -F/ '{print $(NF-1)}')
        echo "default.lua found in Core/$filename, removing $filename.rst if it exists"
        rm -f "$applicationsfolder/$filename.rst"
    fi
done

# Remove aoc, gcc, intel, openmpi, and intel-mpi since they come under Compilers and MPIs
declare -a filestoberemoved=(
[0]=aocc
[1]=gcc
[2]=intel
[3]=openmpi
[4]=impi
)
for filename in ${filestoberemoved[@]}; do
    rm -f "$applicationsfolder/$filename.rst"
done

# Remove listofmissingfiles
rm listofmissingfiles.txt

# Update index.rst

indexfile="/$repo_path/index.rst"
cd $repo_path

subfoldersarray=`ls -d */`

sed -i '/.. toctree::/,$d' $indexfile

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for eachfolder in $subfoldersarray
do
    if [ "$eachfolder" != "Scripts/" ]; then
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