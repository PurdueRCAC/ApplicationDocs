#! /bin/bash
# This script generates documentation files for impi, openmpi, intel-oneapi-mpi, and mvapich2 from the latest version from intel from all the clusters under the MPIs folder and then updates index.rst
# Example Usage: ./generatempisdocumentationallclusters.sh

declare -a listofmissingfiles=(
[0]=impi
[1]=openmpi
[2]=intel-oneapi-mpi
[3]=mvapich2
)

current_dir="$PWD" # save current directory 
cd ../ # go up one directory
repo_path="$PWD" # assign path to repo_path
cd $current_dir # cd back to current directory

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

function generateLuaFilesIfNew() {
    for filename in ${listofmissingfiles[@]}; do 
        echo ""
        echo $filename

        inputfolder="$luasource/$filename/"
        echo "input folder: "$inputfolder
        if [ ! -d "$inputfolder" ] 
        then
            echo "File does not exist, skipping"
            continue; # Skip if one of the mpis does not exist
        fi

        filenamesarray=`ls -v $inputfolder*.lua`
        for eachfile in $filenamesarray
        do
            inputpath=$eachfile #This assumes last file name in alphabetical order is the file to parse
        done
        echo "input path: "$inputpath

        containername=$(echo $inputpath | awk -F/ '{print $(NF-1)}')

        outputfile="$repo_path/MPIs/$containername.rst"
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


clustername=Bell
luasource=$bell/intel/19.0.5
generateLuaFilesIfNew

clustername=Brown
luasource=$brown/intel/19.0.3
generateLuaFilesIfNew

clustername=Scholar
luasource=$scholar/intel/19.0.3
generateLuaFilesIfNew

clustername=Gilbreth
luasource=$gilbreth/intel/19.0.5
generateLuaFilesIfNew

clustername=Negishi
luasource=$negishi/intel/19.1.3
generateLuaFilesIfNew
luasource=$negishi/oneapi/2023.0.0
generateLuaFilesIfNew

clustername=Anvil
luasource=$anvil1/intel/19.0.5
generateLuaFilesIfNew
luasource=$anvil2/intel/19.0.5
generateLuaFilesIfNew

clustername=Workbench
luasource=$workbench/intel/19.0.3
generateLuaFilesIfNew


# Update index.rst

indexfile="/$repo_path/index.rst"
cd $repo_path

# subfoldersarray=`ls -d */`
declare -a subfoldersarray=(
[0]=FAQs/
[1]=Compilers/
[2]=MPIs/
[3]=Applications/
[4]=NGC/
[5]=ROCm/
)

sed -i '/.. toctree::/,$d' $indexfile

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for eachfolder in ${subfoldersarray[@]}
do
    if [ "$eachfolder" != "Scripts/" ] && [ "$eachfolder" != "images/" ] && [ "$eachfolder" != "Clusters/" ]; then
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