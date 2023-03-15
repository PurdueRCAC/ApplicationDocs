#! /bin/bash
# This script generates documentation files for utilities files of all the clusters under the Utilities folder and then updates index.rst
# Example Usage: ./generateutilitiesdocumentationallclusters.sh

current_dir="$PWD" # save current directory 
cd ../ # go up one directory
repo_path="$PWD" # assign path to repo_path
cd $current_dir # cd back to current directory

# Assign shortcuts for cluster paths
export bell="$repo_path/Clusters/xCAT-Bell-Configuration/puppet/modules/common/files/opt/spack/modulefiles"
export brown="$repo_path/Clusters/xCAT-Brown-Configuration/puppet/modules/common/files/opt/spack/modulefiles"
export scholar="$repo_path/Clusters/Scholar-Modulefiles/opt/spack/modulefiles"
export gilbreth="$repo_path/Clusters/xCAT-Gilbreth-Configuration/puppet/modules/common/files/opt/spack/modulefiles"

clusternames=("$bell" "$brown" "$scholar" "$gilbreth")

# Git pull on all clusters. Uncomment to pull every time the script is run
# for name in ${clusternames[@]}; do
#     cd $name
#     git pull
# done

function generateListOfMissingFilesWithoutSubfolders() {
    diff -X scannedfiles.txt -q $applicationsfolder $luasource | grep "Only in $repo_path/Clusters/" > tempfile.txt
    awk 'NF{ print $NF }' tempfile.txt > listofmissingfiles.txt
    rm scannedfiles.txt
    rm tempfile.txt
    readarray -t listofmissingfiles < listofmissingfiles.txt
    rm listofmissingfiles.txt
}

function generateListOfMissingFilesFromSubfolders() {
    diff -x '*.lua' -q $applicationsfolder $luasource | grep "Only in $repo_path/Clusters/" > tempfile.txt
    awk 'NF{ print $NF }' tempfile.txt > listofmissingfiles.txt
    awk 'NF{ print $NF }' tempfile.txt > scannedfiles.txt
    rm tempfile.txt
    readarray -t listofmissingfiles < listofmissingfiles.txt
}

function generateLuaFilesFromSubfolders() {
    for filename in ${listofmissingfiles[@]}; do 
        echo ""
        echo $filename

        inputfolder="$luasource/$filename/"
        echo "input folder: "$inputfolder
        if [ ! -d "$inputfolder" ] 
        then
            echo "File does not exist, skipping"
            continue; # Skip if one of the Utilities files does not exist
        fi

        filenamesarray=`ls -v $inputfolder*.lua`
        for eachfile in $filenamesarray
        do
            inputpath=$eachfile #This assumes last file name in alphabetical order is the file to parse
        done
        echo "input path: "$inputpath

        containername=$(echo $inputpath | awk -F/ '{print $(NF-1)}')

        outputfile="$repo_path/Utilities/$containername.rst"
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
            echo "    module load utilities" >> $outputfile
            echo "    module load $containername" >> $outputfile
            echo "" >> $outputfile
        fi
        

    done
}

function generateLuaFilesWithoutSubfolders() {
    for filename in ${listofmissingfiles[@]}; do 
        echo ""
        echo $filename

        inputpath="$luasource/$filename"
        echo "input path: "$inputpath

        if [ ! "$inputpath" ] 
        then
            echo "File does not exist, skipping"
            continue; # Skip if one of the Utilities files does not exist
        fi

        containername=$(echo $inputpath | awk -F/ '{print $(NF)}')
        containername=${containername::-4}
        outputfile="$repo_path/Utilities/$containername.rst"
        echo "output file: "$outputfile

        if test -f "$outputfile"; then
            echo "$outputfile exists from previous clusters, updating versions"

            # Check if a line from the cluster exists in the versions section
            if grep -Fq "$clustername" "$outputfile"
            then
                # code if found
                echo "$clustername found in versions, replacing line"
                echo -n "$clustername" > tempfile.rst
                tempfilecontent=$(<tempfile.rst)
                # echo $tempfilecontent
                linenumbermatchingclustername=`grep -n -m 1 "$clustername" $outputfile | cut -f1 -d ":"` #prints the line number of the matched first occurrence
                # echo $linenumbermatchingclustername
                sed -i "$linenumbermatchingclustername"d $outputfile # Delete line at particular number
                sed -i "$linenumbermatchingclustername i - $tempfilecontent" $outputfile # Insert line at particular number
            else
                # code if not found
                echo "$clustername not found in versions, adding new line"
                
                echo -n "$clustername" > tempfile.rst
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

            echo "Availibility" >> $outputfile
            echo "~~~~~~~~" >> $outputfile
            echo -n "- $clustername" >> $outputfile
            echo "" >> $outputfile
            echo "" >> $outputfile
            echo "Module" >> $outputfile
            echo "~~~~~~~~" >> $outputfile
            echo "You can load the modules by::" >> $outputfile
            echo "" >> $outputfile
            echo "    module load utilities" >> $outputfile
            echo "    module load $containername" >> $outputfile
            echo "" >> $outputfile
        fi
        

    done
}


applicationsfolder="$repo_path/Utilities/"

clustername=Bell
luasource=$bell/utilities
generateListOfMissingFilesFromSubfolders
generateLuaFilesFromSubfolders
generateListOfMissingFilesWithoutSubfolders
generateLuaFilesWithoutSubfolders

clustername=Brown
luasource=$brown/utilities
generateListOfMissingFilesFromSubfolders
generateLuaFilesFromSubfolders
generateListOfMissingFilesWithoutSubfolders
generateLuaFilesWithoutSubfolders

clustername=Scholar
luasource=$scholar/utilities
generateListOfMissingFilesFromSubfolders
generateLuaFilesFromSubfolders
generateListOfMissingFilesWithoutSubfolders
generateLuaFilesWithoutSubfolders

clustername=Gilbreth
luasource=$gilbreth/utilities
generateListOfMissingFilesFromSubfolders
generateLuaFilesFromSubfolders
generateListOfMissingFilesWithoutSubfolders
generateLuaFilesWithoutSubfolders


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
        rm listofcategories2.txt
        
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