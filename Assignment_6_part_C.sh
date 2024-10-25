#!/bin/bash


clearLogFile() {
    if [ -f "$1" ]; then
        > "$1"
        echo "Cleared log file: $1"
    else
        echo "Log file $1 does not exist."
    fi
}


deleteLogFile() {
    if [ -f "$1" ]; then
        rm "$1"
        echo "Deleted log file: $1"
        echo "Note: If the process is writing to this file, it may create a new log file upon the next write."
    else
        echo "Log file $1 does not exist."
    fi
}


elevatePriority() {
    if ps -p "$1" > /dev/null; then
        renice -10 -p "$1"
        echo "Elevated priority of process with PID $1 to -10."
    else
        echo "Process with PID $1 does not exist."
    fi
}


case $1 in
    clearLogFile)
        if [ -n "$2" ]; then
            clearLogFile "$2"
        else
            echo "Usage: $0 clearLogFile <log_file_path>"
        fi
        ;;
    deleteLogFile)
        if [ -n "$2" ]; then
            deleteLogFile "$2"
        else
            echo "Usage: $0 deleteLogFile <log_file_path>"
        fi
        ;;
    elevatePriority)
        if [ -n "$2" ]; then
            elevatePriority "$2"
        else
            echo "Usage: $0 elevatePriority <PID>"
        fi
        ;;
    *)
        echo "Invalid command. Usage:"
        echo "$0 clearLogFile <log_file_path>"
        echo "$0 deleteLogFile <log_file_path>"
        echo "$0 elevatePriority <PID>"
        ;;
esac

