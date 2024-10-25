#!/bin/bash

create_tag() {
    git tag "$1"
    echo "Created tag: $1"
}

list_tags() {
    git tag
}

delete_tag() {
    git tag -d "$1"
    echo "Deleted tag: $1"
}

case "$1" in
    -t)
        if [ -n "$2" ]; then
            create_tag "$2"
        else
            echo "Usage: $0 -t <tag_name>"
        fi
        ;;
    -l)
        list_tags
        ;;
    -d)
        if [ -n "$2" ]; then
            delete_tag "$2"
        else
            echo "Usage: $0 -d <tag_name>"
        fi
        ;;
    *)
        echo "Invalid option. Use -t <tag_name> to create, -l to list, or -d <tag_name> to delete."
        ;;
esac

