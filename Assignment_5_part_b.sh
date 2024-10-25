#!/bin/bash

addLineTop() {
    sed -i "1i $2" "$1"
}
addLineBottom() {
    echo "$2" >> "$1"
}
addLineAt() {
    sed -i "${2}i $3" "$1"   
}
updateFirstWord() {
    sed -i "0,/$2/s//$3/" "$1"
}
updateAllWords() {
    sed -i "s/$2/$3/g" "$1"
}
insertWord() {
    sed -i "s/\($2\)/\1 $4/g" "$1"
}
deleteLine() {
    sed -i "${2}d" "$1"
}
deleteLineContaining() {
    sed -i "/$2/d" "$1"
}

case $1 in
    addLineTop)
        addLineTop "$2" "$3"
        ;;
    addLineBottom)
        addLineBottom "$2" "$3"
        ;;
    addLineAt)
        addLineAt "$2" "$3" "$4"
        ;;
    updateFirstWord)
        updateFirstWord "$2" "$3" "$4"
        ;;
    updateAllWords)
        updateAllWords "$2" "$3" "$4"
        ;;
    insertWord)
        insertWord "$2" "$3" "$4" "$5"
        ;;
    deleteLine)
        deleteLine "$2" "$3"
        ;;
    deleteLineContaining)
        deleteLineContaining "$2" "$3"
        ;;
    *)
        echo "Invalid command"
        ;;
esac

