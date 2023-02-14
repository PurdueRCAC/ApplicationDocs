#! /bin/bash
# This script generates documentation files for rocmcontainers files of all the clusters under the ROCm folder and then updates index.rst
# Example Usage: ./generaterocmdocumentationallclusters.sh

current_dir="$PWD" # save current directory 
cd ../ # go up one directory
repo_path="$PWD" # assign path to repo_path
cd $current_dir # cd back to current directory

export bell="$repo_path/Clusters/xCAT-Bell-Configuration/puppet/modules/common/files/opt/spack/modulefiles"
export negishi="$repo_path/Clusters/Negishi-Modulefiles"

clusternames=("$bell" "$negishi")

# Git pull on all clusters. Uncomment to pull every time the script is run
# for name in ${clusternames[@]}; do
#     cd $name
#     git pull
# done

function generateListOfMissingFiles() {
    diff -x '*.lua' -q $applicationsfolder $luasource | grep "Only in $repo_path/Clusters/" > tempfile.txt
    awk 'NF{ print $NF }' tempfile.txt > listofmissingfiles.txt
    rm tempfile.txt
    readarray -t listofmissingfiles < listofmissingfiles.txt
    rm listofmissingfiles.txt
}

function generateLuaFilesIfNew() {
    for filename in ${listofmissingfiles[@]}; do 
        echo ""
        echo $filename

        inputfolder="$luasource/$filename/"
        echo "input folder: "$inputfolder
        if [ ! -d "$inputfolder" ] 
        then
            echo "File does not exist, skipping"
            continue; # Skip if one of the ROCm files does not exist
        fi

        filenamesarray=`ls -v $inputfolder*.lua`
        for eachfile in $filenamesarray
        do
            inputpath=$eachfile #This assumes last file name in alphabetical order is the file to parse
        done
        echo "input path: "$inputpath

        containername=$(echo $inputpath | awk -F/ '{print $(NF-1)}')

        outputfile="$repo_path/ROCm/$containername.rst"
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
            echo "    module load rocmcontainers" >> $outputfile
            echo "    module load $containername" >> $outputfile
            echo "" >> $outputfile
            echo "Example job" >> $outputfile
            echo "~~~~~" >> $outputfile
            echo ".. warning::" >> $outputfile
            echo "    Using \`\`#!/bin/sh -l\`\` as shebang in the slurm job script will cause the failure of some biocontainer modules. Please use \`\`#!/bin/bash\`\` instead." >> $outputfile
            echo "" >> $outputfile
            echo "To run $containername on our clusters::" >> $outputfile
            echo "" >> $outputfile
            echo -e "    #!/bin/bash\n    #SBATCH -A myallocation     # Allocation name\n    #SBATCH -t 1:00:00\n    #SBATCH -N 1\n    #SBATCH -n 1\n    #SBATCH --job-name=$containername\n    #SBATCH --mail-type=FAIL,BEGIN,END\n    #SBATCH --error=%x-%J-%u.err\n    #SBATCH --output=%x-%J-%u.out" >> $outputfile
            echo "" >> $outputfile
            echo "    module --force purge" >> $outputfile
            echo "    ml rocmcontainers $containername" >> $outputfile
            echo "" >> $outputfile
        fi
        

    done
}

applicationsfolder="$repo_path/ROCm/"

clustername=Bell
luasource=$bell/rocmcontainers
generateListOfMissingFiles
generateLuaFilesIfNew

clustername=Negishi
luasource=$negishi/rocmcontainers
generateListOfMissingFiles
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