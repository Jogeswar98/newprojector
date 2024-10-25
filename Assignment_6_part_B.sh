#!/bin/bash

registry_file="/etc/process_manager_registry.txt"

registerService() {
    echo "$2 $3" >> "$registry_file"
    echo "Registered service with alias '$3' at '$2'"
}

startService() {
    service_path=$(grep -w "$2" "$registry_file" | awk '{print $1}')
    if [ -n "$service_path" ]; then
        nohup "$service_path" &> /dev/null &
        echo "$!" > "/tmp/$2.pid"
        echo "Started service '$2'"
    else
        echo "Service alias '$2' not found."
    fi
}

statusService() {
    if [ -f "/tmp/$2.pid" ]; then
        if ps -p "$(cat "/tmp/$2.pid")" > /dev/null; then
            echo "Service '$2' is running."
        else
            echo "Service '$2' is not running."
        fi
    else
        echo "Service alias '$2' not found."
    fi
}

stopService() {
    if [ -f "/tmp/$2.pid" ]; then
        kill -9 "$(cat "/tmp/$2.pid")" && rm "/tmp/$2.pid"
        echo "Stopped service '$2'"
    else
        echo "Service alias '$2' not found."
    fi
}
changePriority() {
    pid=$(cat "/tmp/$2.pid" 2>/dev/null)
    if [ -n "$pid" ]; then
        case $3 in
            low) renice 19 -p "$pid" ;;
            med) renice 10 -p "$pid" ;;
            high) renice -20 -p "$pid" ;;
        esac
        echo "Priority of service '$2' set to $3."
    else
        echo "Service alias '$2' not found."
    fi
}
listServices() {
    cat "$registry_file"
}
showProcessDetails() {
    pid=$(cat "/tmp/$2.pid" 2>/dev/null)
    if [ -n "$pid" ]; then
        ps -p "$pid" -o pid,stat,pri,comm
    else
        echo "Service alias '$2' not found."
    fi
}

case $1 in
    -o)
        case $2 in
            register) registerService "$3" "$5" ;;
            start) startService "$4" ;;
            status) statusService "$4" ;;
            kill) stopService "$4" ;;
            priority) changePriority "$6" "$4" ;;
            list) listServices ;;
            top) showProcessDetails "$4" ;;
            *) echo "Invalid operation." ;;
        esac
        ;;
    *) echo "Invalid command syntax." ;;
esac

