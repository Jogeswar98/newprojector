#!bin/bash

choice=$1
path=$2
dir_file=$3
num=$4
case $choice in
addDir)
	mkdir -p /$path/$dir_file
	;;
listFiles)
        ls -p /$path | grep -v /
	;;	
listDirs)
       ls -d /$tmp/*/ ;;
listAll)
        cd /$path/
        ls -al ;;
deleteDir)
        rm -rf  $path/$dir_file
        ;;
addFile)
        echo "initial content " > /$path/$dir_file
	;;
addContentToFile)
	echo " additional content " >> /$path/$dir_file
	;;
showFileBeginingContent)
	head -n $num /$path/$dir_file
	;;
showFileEndContent)	
        tail -n $num /$path/$dir_file
	;;	
showFileContentAtLine)
        head -n $num /$path/$dir_file | tail -n 1
	;;	    
showFileContentForLineRange)
        head -n 10 /$path/$dir_file | tail -n 5
			   ;;
moveFile)
        mv $path $dir_file
        ;;
copyFile)
        cp $path $dir_file	
	;;
clearFileContent)	
	cat > /$path/$dir_file
	;;
deleteFile)
         rm -rf /$path/$dir_file
esac
