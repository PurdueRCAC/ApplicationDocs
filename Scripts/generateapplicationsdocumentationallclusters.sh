#!/bin/bash
# This script generates documentation files under the Applications folder from all the clusters and then updates index.rst
# Example Usage: ./generateapplicationsdocumentationallclusters.sh

current_dir="$PWD" # save current directory 
cd ../ # go up one directory
repo_path="$PWD" # assign path to repo_path
cd $current_dir # cd back to current directory

# Assign shortcuts for all cluster paths
export bell="$repo_path/Clusters/xCAT-Bell-Configuration/puppet/modules/common/files/opt/spack/modulefiles"
export brown="$repo_path/Clusters/xCAT-Brown-Configuration/puppet/modules/common/files/opt/spack/modulefiles"
export scholar="$repo_path/Clusters/Scholar-Modulefiles/opt/spack/modulefiles"
export gilbreth="$repo_path/Clusters/xCAT-Gilbreth-Configuration/puppet/modules/common/files/opt/spack/modulefiles"
export negishi="$repo_path/Clusters/Negishi-Modulefiles/cpu-20221214"
export anvil1="$repo_path/Clusters/Anvil-Modulefiles/cpu-20211007"
export anvil2="$repo_path/Clusters/Anvil-Modulefiles/gpu-20211014"
export workbench="$repo_path/Clusters/xCAT-Workbench-Configuration/puppet/modules/common/files/opt/spack/modulefiles"

clusternames=("$bell" "$brown" "$scholar" "$gilbreth" "$negishi" "$anvil1" "$anvil2" "$workbench")

# Git pull on all clusters. Uncomment to pull every time the script is run
# for name in ${clusternames[@]}; do
#     cd $name
#     git pull
# done

cd $current_dir

function generateListOfMissingFiles() {
    diff -x '*.lua' -q $applicationsfolder $luasource | grep "Only in $repo_path/Clusters/" > tempfile.txt
    awk 'NF{ print $NF }' tempfile.txt > listofmissingfiles.txt
    rm tempfile.txt
    readarray -t listofmissingfiles < listofmissingfiles.txt
}

function generateLuaFilesIfNew() {
    for filename in ${listofmissingfiles[@]}; do 
        echo ""
        if [ "$filename" == "all" ]; then
            continue
        fi
        echo $filename

        inputfolder="$luasource/$filename/"
        # echo "input folder: "$inputfolder

        filenamesarray=`ls -v $inputfolder*.lua`
        for eachfile in $filenamesarray
        do
            inputpath=$eachfile #This assumes last file name in alphabetical order is the file to parse
        done
        echo "input path: "$inputpath

        containername=$(echo $inputpath | awk -F/ '{print $(NF-1)}')

        outputfile="$repo_path/Applications/$containername.rst"
        echo "output file: "$outputfile
        
        if test -f "$outputfile"; then
            echo "$outputfile exists from previous clusters, updating versions"

            # Check if a line from the cluster exists in the versions section
            if grep -Fq "$clustername: " "$outputfile"
            then
                # code if found
                echo "$clustername found in versions, replacing line"
                echo -n "$clustername: " > tempfile.rst
                for eachfile in $filenamesarray 
                do
                    eachfile2=$eachfile
                    eachfile=${eachfile::-4}
                    echo -n "$eachfile, " | sed 's:.*/::' >> tempfile.rst
                done
                truncate -s -2 tempfile.rst
                tempfilecontent=$(<tempfile.rst)
                # echo $tempfilecontent
                linenumbermatchingclustername=`grep -n -m 1 "$clustername: " $outputfile | cut -f1 -d ":"` #prints the line number of the matched first occurrence
                # echo $linenumbermatchingclustername
                sed -i "$linenumbermatchingclustername"d $outputfile # Delete line at particular number
                sed -i "$linenumbermatchingclustername i - $tempfilecontent" $outputfile # Insert line at particular number
            else
                # code if not found
                echo "$clustername not found in versions, adding new line"
                
                echo -n "$clustername: " > tempfile.rst
                for eachfile in $filenamesarray 
                do
                    eachfile2=$eachfile
                    eachfile=${eachfile::-4}
                    echo -n "$eachfile, " | sed 's:.*/::' >> tempfile.rst
                done
                truncate -s -2 tempfile.rst
                tempfilecontent=$(<tempfile.rst)

                linenumbermatchingclustername=`grep -n -m 1 "Module" $outputfile | cut -f1 -d ":"` #prints the line number of the matched first occurrence
                linenumbermatchingclustername=$((linenumbermatchingclustername-1))
                # echo $linenumbermatchingclustername
                
                sed -i "$linenumbermatchingclustername i - $tempfilecontent" $outputfile # Insert line at particular number
            fi
            
            rm tempfile.rst
        else
            inputpathcontent=$(<$inputpath)

            echo ".. _backbone-label:" > $outputfile
            echo "" >> $outputfile
            echo "$containername" >> $outputfile
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
            echo -n "- $clustername: " >> $outputfile
            for eachfile in $filenamesarray 
            do
                # echo -n "- " >> $outputfile
                eachfile2=$eachfile
                eachfile=${eachfile::-4}
                echo -n "$eachfile, " | sed 's:.*/::' >> $outputfile
            done
            truncate -s -2 $outputfile

            echo "" >> $outputfile
            echo "" >> $outputfile
            echo "Module" >> $outputfile
            echo "~~~~~~~~" >> $outputfile
            echo "You can load the modules by::" >> $outputfile
            echo "" >> $outputfile
            echo "    module load $containername" >> $outputfile
            echo "" >> $outputfile
        fi
    done
}



applicationsfolder="$repo_path/Applications/"


# Generate Lua files from Bell
clustername=Bell

# Generate Lua files from clang
luasource="$bell/clang/9.0.0"
generateListOfMissingFiles
generateLuaFilesIfNew

# Generate Lua files from gcc
luasource="$bell/gcc/4.8.5"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$bell/gcc/6.3.0"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$bell/gcc/9.3.0"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$bell/gcc/10.2.0"
generateListOfMissingFiles
generateLuaFilesIfNew

# Generate Lua files from intel
luasource="$bell/intel/17.0.1"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$bell/intel/19.0.5"
generateListOfMissingFiles
generateLuaFilesIfNew

# Generate Lua files from intel-mpi
luasource="$bell/intel-mpi/2017.1.132-4o27yog/intel/17.0.1"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$bell/intel-mpi/2019.5.281-3fyzsi3/intel/19.0.5"
generateListOfMissingFiles
generateLuaFilesIfNew

# Generate Lua files from ml-toolkit
luasource="$bell/ml-toolkit/conda-2020.11-py38/cpu/modules/ml-toolkit-cpu"
generateListOfMissingFiles
generateLuaFilesIfNew

# Generate Lua files from openmpi
ls "$bell/openmpi/" > openmpifolders.txt
readarray -t openmpifolders < openmpifolders.txt
rm openmpifolders.txt

for foldername in ${openmpifolders[@]}; do
    workingdirectory=$PWD
    cd $bell/openmpi/$foldername
    innerfoldername=`ls`
    cd $innerfoldername
    innermostfoldername=`ls`
    corefiles=$PWD
    cd "$workingdirectory"
    luasource="$bell/openmpi/$foldername/$innerfoldername/$innermostfoldername"
    generateListOfMissingFiles
    generateLuaFilesIfNew
done

# Generate Lua files from utilities
luasource="$bell/utilities"
generateListOfMissingFiles
generateLuaFilesIfNew

# Generate Lua files from Core
luasource="$bell/Core"
generateListOfMissingFiles
generateLuaFilesIfNew

# Remove all files that had default.lua in their subfolder in Core
for dir in $bell/Core/*/
do
    if [ -f "$dir/default.lua" ];
    then
        echo ""
        filename=$(echo $dir | awk -F/ '{print $(NF-1)}')
        echo "default.lua found in Core/$filename, removing $filename.rst if it exists"
        rm -f "$applicationsfolder/$filename.rst"
    fi
done


# Generate Lua files from Brown
clustername=Brown

# Generate Lua files from gcc
luasource="$brown/gcc/4.8.5"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$brown/gcc/5.2.0"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$brown/gcc/6.3.0"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$brown/gcc/7.3.0"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$brown/gcc/8.3.0"
generateListOfMissingFiles
generateLuaFilesIfNew

# Generate Lua files from intel
luasource="$brown/intel/16.0.1"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$brown/intel/17.0.1"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$brown/intel/18.0.1"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$brown/intel/19.0.3"
generateListOfMissingFiles
generateLuaFilesIfNew

# Generate Lua files from intel-mpi
luasource="$brown/intel-mpi/5.1.3.223-onxwrci/intel/16.0.1"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$brown/intel-mpi/2017.1.132-o4mm4ht/intel/17.0.1"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$brown/intel-mpi/2018.1.163-k54k4tv/intel/18.0.1"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$brown/intel-mpi/2019.3.199-tmwwyjx/intel/19.0.3"
generateListOfMissingFiles
generateLuaFilesIfNew

# Generate Lua files from openmpi
ls "$brown/openmpi/" > openmpifolders.txt
readarray -t openmpifolders < openmpifolders.txt
rm openmpifolders.txt

for foldername in ${openmpifolders[@]}; do
    workingdirectory=$PWD
    cd $brown/openmpi/$foldername
    innerfoldername=`ls`
    cd $innerfoldername
    innermostfoldername=`ls`
    corefiles=$PWD
    cd "$workingdirectory"
    luasource="$brown/openmpi/$foldername/$innerfoldername/$innermostfoldername"
    generateListOfMissingFiles
    generateLuaFilesIfNew
done

# Generate Lua files from utilities
luasource="$brown/utilities"
generateListOfMissingFiles
generateLuaFilesIfNew

# Generate Lua files from Core
luasource="$brown/Core"
generateListOfMissingFiles
generateLuaFilesIfNew

# Remove all files that had default.lua in their subfolder in Core
for dir in $brown/Core/*/
do
    if [ -f "$dir/default.lua" ];
    then
        echo ""
        filename=$(echo $dir | awk -F/ '{print $(NF-1)}')
        echo "default.lua found in Core/$filename, removing $filename.rst if it exists"
        rm -f "$applicationsfolder/$filename.rst"
    fi
done


# Generate Lua files from Scholar
clustername=Scholar

# Generate Lua files from gcc
luasource="$scholar/gcc/4.8.5"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$scholar/gcc/5.2.0"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$scholar/gcc/6.3.0"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$scholar/gcc/7.3.0"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$scholar/gcc/8.3.0"
generateListOfMissingFiles
generateLuaFilesIfNew

# Generate Lua files from intel
luasource="$scholar/intel/16.0.1"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$scholar/intel/17.0.1"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$scholar/intel/18.0.1"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$scholar/intel/19.0.3"
generateListOfMissingFiles
generateLuaFilesIfNew

# Generate Lua files from intel-mpi
ls "$scholar/intel-mpi" > intelmpifolders.txt
readarray -t intelmpifolders < intelmpifolders.txt
rm intelmpifolders.txt

for foldername in ${intelmpifolders[@]}; do
    workingdirectory=$PWD
    cd $scholar/intel-mpi/$foldername
    innerfoldername=`ls`
    cd $innerfoldername
    innermostfoldername=`ls`
    corefiles=$PWD
    cd "$workingdirectory"
    luasource="$scholar/intel-mpi/$foldername/$innerfoldername/$innermostfoldername"
    generateListOfMissingFiles
    generateLuaFilesIfNew
done

# Generate Lua files from utilities
luasource="$scholar/utilities"
generateListOfMissingFiles
generateLuaFilesIfNew

# Generate Lua files from Core
luasource="$scholar/Core"
generateListOfMissingFiles
generateLuaFilesIfNew

# Remove all files that had default.lua in their subfolder in Core
for dir in $scholar/Core/*/
do
    if [ -f "$dir/default.lua" ];
    then
        echo ""
        filename=$(echo $dir | awk -F/ '{print $(NF-1)}')
        echo "default.lua found in Core/$filename, removing $filename.rst if it exists"
        rm -f "$applicationsfolder/$filename.rst"
    fi
done


# Generate Lua files from Gilbreth
clustername=Gilbreth

# Generate Lua files from gcc
luasource="$gilbreth/gcc/4.8.5"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$gilbreth/gcc/6.3.0"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$gilbreth/gcc/9.3.0"
generateListOfMissingFiles
generateLuaFilesIfNew

# Generate Lua files from intel
luasource="$gilbreth/intel/16.0.1"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$gilbreth/intel/17.0.1"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$gilbreth/intel/18.0.1"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$gilbreth/intel/19.0.3"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$gilbreth/intel/19.0.5"
generateListOfMissingFiles
generateLuaFilesIfNew

# Generate Lua files from intel-mpi
luasource="$gilbreth/intel-mpi/5.1.3.223-onxwrci/intel/16.0.1"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$gilbreth/intel-mpi/2017.1.132-gv3qcle/intel/gcc-6.3.0_17.0.1"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$gilbreth/intel-mpi/2017.1.132-o4mm4ht/intel/17.0.1"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$gilbreth/intel-mpi/2018.1.163-k54k4tv/intel/18.0.1"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$gilbreth/intel-mpi/2019.3.199-tmwwyjx/intel/19.0.3"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$gilbreth/intel-mpi/2019.5.281-jwqfg2d/intel/19.0.5"
generateListOfMissingFiles
generateLuaFilesIfNew

# Generate Lua files from ml-toolkit
luasource="$gilbreth/ml-toolkit/conda-5.1.0-py27/cpu/modules/ml-toolkit-cpu"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$gilbreth/ml-toolkit/conda-5.1.0-py36/cpu/modules/ml-toolkit-cpu"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$gilbreth/ml-toolkit/conda-2020.11-py38/cpu/modules/ml-toolkit-cpu"
generateListOfMissingFiles
generateLuaFilesIfNew

# Generate Lua files from openmpi
ls "$gilbreth/openmpi/" > openmpifolders.txt
readarray -t openmpifolders < openmpifolders.txt
rm openmpifolders.txt

for foldername in ${openmpifolders[@]}; do
    workingdirectory=$PWD
    cd $gilbreth/openmpi/$foldername
    innerfoldername=`ls`
    cd $innerfoldername
    innermostfoldername=`ls`
    corefiles=$PWD
    cd "$workingdirectory"
    luasource="$gilbreth/openmpi/$foldername/$innerfoldername/$innermostfoldername"
    generateListOfMissingFiles
    generateLuaFilesIfNew
done

# Generate Lua files from utilities
luasource="$gilbreth/utilities"
generateListOfMissingFiles
generateLuaFilesIfNew

# Generate Lua files from Core
luasource="$gilbreth/Core"
generateListOfMissingFiles
generateLuaFilesIfNew

# Remove all files that had default.lua in their subfolder in Core
for dir in $gilbreth/Core/*/
do
    if [ -f "$dir/default.lua" ];
    then
        echo ""
        filename=$(echo $dir | awk -F/ '{print $(NF-1)}')
        echo "default.lua found in Core/$filename, removing $filename.rst if it exists"
        rm -f "$applicationsfolder/$filename.rst"
    fi
done


# Generate Lua files from Negishi
clustername=Negishi

# Generate Lua files from gcc
luasource="$negishi/gcc/8.5.0"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$negishi/gcc/11.2.0"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$negishi/gcc/12.2.0"
generateListOfMissingFiles
generateLuaFilesIfNew

# Generate Lua files from intel
luasource="$negishi/intel/19.1.3"
generateListOfMissingFiles
generateLuaFilesIfNew

# Generate Lua files from intel-mpi
luasource="$negishi/intel-mpi/2019.9.304-sybnadz/intel/19.1.3"
generateListOfMissingFiles
generateLuaFilesIfNew

# Generate Lua files from mvapich2
ls "$negishi/mvapich2/" > mvapich2folders.txt
readarray -t mvapich2folders < mvapich2folders.txt
rm mvapich2folders.txt

for foldername in ${mvapich2folders[@]}; do
    workingdirectory=$PWD
    cd $negishi/mvapich2/$foldername
    innerfoldername=`ls`
    cd $innerfoldername
    innermostfoldername=`ls`
    corefiles=$PWD
    cd "$workingdirectory"
    luasource="$negishi/mvapich2/$foldername/$innerfoldername/$innermostfoldername"
    generateListOfMissingFiles
    generateLuaFilesIfNew
done

# Generate Lua files from oneapi
luasource="$negishi/oneapi/2023.0.0"
generateListOfMissingFiles
generateLuaFilesIfNew

# Generate Lua files from openmpi
ls "$negishi/openmpi/" > openmpifolders.txt
readarray -t openmpifolders < openmpifolders.txt
rm openmpifolders.txt

for foldername in ${openmpifolders[@]}; do
    workingdirectory=$PWD
    cd $negishi/openmpi/$foldername
    innerfoldername=`ls`
    cd $innerfoldername
    innermostfoldername=`ls`
    corefiles=$PWD
    cd "$workingdirectory"
    luasource="$negishi/openmpi/$foldername/$innerfoldername/$innermostfoldername"
    generateListOfMissingFiles
    generateLuaFilesIfNew
done

# Generate Lua files from Core
luasource="$negishi/Core"
generateListOfMissingFiles
generateLuaFilesIfNew

# Remove all files that had default.lua in their subfolder in Core
for dir in $negishi/Core/*/
do
    if [ -f "$dir/default.lua" ];
    then
        echo ""
        filename=$(echo $dir | awk -F/ '{print $(NF-1)}')
        echo "default.lua found in Core/$filename, removing $filename.rst if it exists"
        rm -f "$applicationsfolder/$filename.rst"
    fi
done

# Generate Lua files from Anvil cpu and gpu
clustername=Anvil

# Generate Lua files from aocc
luasource="$anvil1/aocc/3.1.0"
generateListOfMissingFiles
generateLuaFilesIfNew

# Generate Lua files from gcc
luasource="$anvil1/gcc/8.4.1"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$anvil2/gcc/8.4.1"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$anvil1/gcc/10.2.0"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$anvil1/gcc/11.2.0"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$anvil2/gcc/11.2.0"
generateListOfMissingFiles
generateLuaFilesIfNew

# Generate Lua files from intel
luasource="$anvil1/intel/19.0.5"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$anvil2/intel/19.0.5"
generateListOfMissingFiles
generateLuaFilesIfNew

# Generate Lua files from intel-mpi
luasource="$anvil1/intel-mpi/2019.5.281-6qe2yeg/intel/19.0.5"
generateListOfMissingFiles
generateLuaFilesIfNew

# Generate Lua files from mvapich2
ls "$anvil1/mvapich2/" > mvapich2folders.txt
readarray -t mvapich2folders < mvapich2folders.txt
rm mvapich2folders.txt

for foldername in ${mvapich2folders[@]}; do
    workingdirectory=$PWD
    cd $anvil1/mvapich2/$foldername
    innerfoldername=`ls`
    cd $innerfoldername
    innermostfoldername=`ls`
    corefiles=$PWD
    cd "$workingdirectory"
    luasource="$anvil1/mvapich2/$foldername/$innerfoldername/$innermostfoldername"
    generateListOfMissingFiles
    generateLuaFilesIfNew
done

luasource="$anvil2/mvapich2/2.3.6-6uwxfye/gcc/8.4.1"
generateListOfMissingFiles
generateLuaFilesIfNew

# Generate Lua files from openmpi
ls "$anvil1/openmpi/" > openmpifolders.txt
readarray -t openmpifolders < openmpifolders.txt
rm openmpifolders.txt

for foldername in ${openmpifolders[@]}; do
    workingdirectory=$PWD
    cd $anvil1/openmpi/$foldername
    innerfoldername=`ls`
    cd $innerfoldername
    innermostfoldername=`ls`
    corefiles=$PWD
    cd "$workingdirectory"
    luasource="$anvil1/openmpi/$foldername/$innerfoldername/$innermostfoldername"
    generateListOfMissingFiles
    generateLuaFilesIfNew
done

ls "$anvil2/openmpi/" > openmpifolders.txt
readarray -t openmpifolders < openmpifolders.txt
rm openmpifolders.txt

for foldername in ${openmpifolders[@]}; do
    workingdirectory=$PWD
    cd $anvil2/openmpi/$foldername
    innerfoldername=`ls`
    cd $innerfoldername
    innermostfoldername=`ls`
    corefiles=$PWD
    cd "$workingdirectory"
    luasource="$anvil2/openmpi/$foldername/$innerfoldername/$innermostfoldername"
    generateListOfMissingFiles
    generateLuaFilesIfNew
done

# Generate Lua files from Core
luasource="$anvil1/Core"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$anvil2/Core"
generateListOfMissingFiles
generateLuaFilesIfNew

# Remove all files that had default.lua in their subfolder in Core
for dir in $anvil1/Core/*/
do
    if [ -f "$dir/default.lua" ];
    then
        echo ""
        filename=$(echo $dir | awk -F/ '{print $(NF-1)}')
        echo "default.lua found in Core/$filename, removing $filename.rst if it exists"
        rm -f "$applicationsfolder/$filename.rst"
    fi
done

for dir in $anvil2/Core/*/
do
    if [ -f "$dir/default.lua" ];
    then
        echo ""
        filename=$(echo $dir | awk -F/ '{print $(NF-1)}')
        echo "default.lua found in Core/$filename, removing $filename.rst if it exists"
        rm -f "$applicationsfolder/$filename.rst"
    fi
done


# Generate Lua files from Workbench
clustername=Workbench

# Generate Lua files from gcc
luasource="$workbench/gcc/5.2.0"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$workbench/gcc/6.3.0"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$workbench/gcc/7.3.0"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$workbench/gcc/8.3.0"
generateListOfMissingFiles
generateLuaFilesIfNew

# Generate Lua files from intel
luasource="$workbench/intel/16.0.1"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$workbench/intel/17.0.1"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$workbench/intel/18.0.1"
generateListOfMissingFiles
generateLuaFilesIfNew

luasource="$workbench/intel/19.0.3"
generateListOfMissingFiles
generateLuaFilesIfNew

# Generate Lua files from intel-mpi
luasource="$workbench/intel-mpi/2017.1.132-7wa5zgh/intel/17.0.1"
generateListOfMissingFiles
generateLuaFilesIfNew

# Generate Lua files from utilities
luasource="$workbench/utilities"
generateListOfMissingFiles
generateLuaFilesIfNew

# Generate Lua files from Core
luasource="$workbench/Core"
generateListOfMissingFiles
generateLuaFilesIfNew

# Remove all files that had default.lua in their subfolder in Core
for dir in $workbench/Core/*/
do
    if [ -f "$dir/default.lua" ];
    then
        echo ""
        filename=$(echo $dir | awk -F/ '{print $(NF-1)}')
        echo "default.lua found in Core/$filename, removing $filename.rst if it exists"
        rm -f "$applicationsfolder/$filename.rst"
    fi
done



# Remove aoc, gcc, intel, openmpi, intel-mpi, intel-oneapi-compilers, intel-oneapi-mpi, and mvapich2 since they come under Compilers and MPIs
declare -a filestoberemoved=(
[0]=aocc
[1]=gcc
[2]=intel
[3]=openmpi
[4]=impi
[5]=intel-oneapi-compilers
[6]=intel-oneapi-mpi
[7]=mvapich2
)
for filename in ${filestoberemoved[@]}; do
    rm -f "$applicationsfolder/$filename.rst"
done

# Remove listofmissingfiles
rm listofmissingfiles.txt


# Update index.rst

indexfile="/$repo_path/index.rst"
cd $repo_path

# subfoldersarray=`ls -d */`
declare -a subfoldersarray=(
[0]=FAQs/
[1]=Compilers/
[2]=MPIs/
[3]=Applications/
[4]=Utilities/
[5]=Biocontainers/
[6]=NGC/
[7]=ROCm/
)

sed -i '/.. toctree::/,$d' $indexfile

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

echo ".. toctree::" >> $indexfile
echo "   :maxdepth: 2" >> $indexfile
echo "" >> $indexfile

for eachfolder in ${subfoldersarray[@]}
do
    if [ "$eachfolder" != "Scripts/" ] && [ "$eachfolder" != "images/" ] && [ "$eachfolder" != "Clusters/" ] && [ "$eachfolder" != "Applications/" ] && [ "$eachfolder" != "Biocontainers/" ]; then
        echo "each folder : $eachfolder"
        eachfolderwithspaces="${eachfolder//_/ }"
        echo "   "${eachfolderwithspaces::-1} >> $indexfile
        subindexfile=${eachfolderwithspaces::-1}.rst
        if [ "$eachfolder" == "NGC/" ]; then
            echo "NVIDIA NGC containers" > $subindexfile
        elif [ "$eachfolder" == "ROCm/" ]; then
            echo "AMD ROCm containers" > $subindexfile
        else
            echo ${eachfolderwithspaces::-1} > $subindexfile
        fi
        echo "==============================================" >> $subindexfile
        echo ".. toctree::" >> $subindexfile
        echo "   :titlesonly:" >> $subindexfile
        echo "" >> $subindexfile
        sourcefolder="$repo_path/$eachfolder"

        echo "source folder : $sourcefolder"
        filenamesarray=`ls "$sourcefolder"`
        for eachfile in $filenamesarray
        do
            eachfile=${eachfile::-4}
            echo "   $eachfolder""$eachfile" >> $subindexfile
        done 
    fi

    if [ "$eachfolder" == "Biocontainers/" ]; then
        svn --force -q export https://github.com/PurdueRCAC/Biocontainers/trunk/docs/source
        rm -r Biocontainers
        mv -f source Biocontainers
        echo "each folder : $eachfolder"
        eachfolderwithspaces="${eachfolder//_/ }"
        echo "   "${eachfolderwithspaces::-1} >> $indexfile
        subindexfile=${eachfolderwithspaces::-1}.rst
        echo ${eachfolderwithspaces::-1} > $subindexfile
        echo "==============================================" >> $subindexfile
        echo ".. toctree::" >> $subindexfile
        echo "   :titlesonly:" >> $subindexfile
        echo "" >> $subindexfile
        sourcefolder="$repo_path/$eachfolder"
        echo "source folder : $sourcefolder"
        foldernamesarray=`ls "$sourcefolder"`
        for eachfile in $foldernamesarray
        do
            echo "   $eachfolder""$eachfile"/"$eachfile" >> $subindexfile
        done
    fi
    
    if [ "$eachfolder" == "Applications/" ]; then
        echo "each folder : $eachfolder"
        eachfolderwithspaces="${eachfolder//_/ }"
        echo "   "${eachfolderwithspaces::-1} >> $indexfile
        subindexfile=${eachfolderwithspaces::-1}.rst
        echo ${eachfolderwithspaces::-1} > $subindexfile
        echo "==============================================" >> $subindexfile

        sourcefolder="$repo_path/$eachfolder"

        echo "source folder : $sourcefolder"
        
        # Application_category.tsv processing
        cut -f 2 Application_category.tsv > listofcategories.txt
        sort listofcategories.txt > listofcategories2.txt
        uniq listofcategories2.txt > listofcategories.txt
#       rm listofcategories2.txt
        
        readarray -t listofcategories < listofcategories.txt # Get the sorted list of all categories
        rm listofcategories.txt
        sort -t$'\t' -k2 Application_category.tsv > sortedentries.txt
        
        readarray -t sortedentries < sortedentries.txt # Get the sorted list of all entries in tsv
        rm sortedentries.txt
        
        for eachcategory in ${listofcategories[@]} # Loop through each category
        do
            # echo "each category : $eachcategory"
            echo $eachcategory >> $subindexfile
            echo "---------------------------------" >> $subindexfile
            echo ".. toctree::" >> $subindexfile
            echo "   :titlesonly:" >> $subindexfile
            echo "" >> $subindexfile
            for eachsortedentry in ${sortedentries[@]} # Loop through each entry
            do
                # echo "each sorted entry : $eachsortedentry"
                firstentry=$(echo $eachsortedentry | awk '{print $1}')
                secondentry=$(echo $eachsortedentry | awk '{print $2}')

                if [[ $eachcategory == $secondentry* ]]; then # Check if entry belongs to this category
                    echo "   $eachfolder""$firstentry" >> $subindexfile
                    echo "      $eachfolder""$firstentry" >> finishedfiles.txt
                fi
                
            done
            echo "" >> $subindexfile
        done
        filenamesarray=`ls "$sourcefolder"` # Get the list of all files in source folder
        for eachfile in $filenamesarray
        do
            eachfile=${eachfile::-4}
            echo "      $eachfolder""$eachfile" >> filesinsourcefolder.txt
        done

        # Processing to find all files that are in source folder but not in Application_category.tsv
        sort filesinsourcefolder.txt > sortedfilesinsourcefolder.txt
        rm filesinsourcefolder.txt
        sort finishedfiles.txt > sortedfinishedfiles.txt
        rm finishedfiles.txt
        diff sortedfinishedfiles.txt sortedfilesinsourcefolder.txt | grep ">" > tempfile.txt
        awk 'NF{ print $NF }' tempfile.txt > listofmissingapplications.txt
        readarray -t listofmissingapplications < listofmissingapplications.txt # List all files that are in source folder but not in Application_category.tsv
        rm tempfile.txt
        rm sortedfinishedfiles.txt
        rm sortedfilesinsourcefolder.txt
        rm listofmissingapplications.txt
        
        echo "" >> $subindexfile
        for filename in ${listofmissingapplications[@]}; do # Adding missing files to index
            echo "$filename" >> $subindexfile
        done
    fi
done
IFS=$SAVEIFS

cd "$current_dir"
