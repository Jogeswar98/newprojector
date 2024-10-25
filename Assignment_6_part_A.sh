#!/bin/bash

topProcess() {
    if [ "$2" == "memory" ]; then
        ps -eo pid,comm,%mem --sort=-%mem | head -n "$(($1 + 1))"
    elif [ "$2" == "cpu" ]; then
        ps -eo pid,comm,%cpu --sort=-%cpu | head -n "$(($1 + 1))"
    else
        echo "Invalid option. Use 'memory' or 'cpu'."
    fi
}

killLeastPriorityProcess() {
    low_priority_pid=$(ps -eo pid,pri --sort=pri | head -n 2 | tail -n 1 | awk '{print $1}')
    kill -9 "$low_priority_pid"
    echo "Killed process with PID $low_priority_pid"
}

runningDurationProcess() {
    ps -p "$1" -o etime=
}

listOrphanProcess() {
    ps -eo pid,ppid,comm | awk '$2 == 1 {print "PID: "$1", Process: "$3}'
}

listZombieProcess() {
    ps -eo pid,stat,comm | awk '$2 ~ /^Z/ {print "PID: "$1", Process: "$3}'
}

killProcess() {
    pid=$(pidof "$1" 2>/dev/null || echo "$1")
    if kill -9 "$pid"; then
        echo "Killed process with PID/Name $1"
    else
        echo "Failed to kill process $1"
    fi
}

listWaitingProcess() {
    ps -eo pid,stat,comm | awk '$2 ~ /^D/ {print "PID: "$1", Process: "$3}'
}

case $1 in
    topProcess) topProcess "$2" "$3" ;;
    killLeastPriorityProcess) killLeastPriorityProcess ;;
    RunningDurationProcess) runningDurationProcess "$2" ;;
    listOrphanProcess) listOrphanProcess ;;
    listZoombieProcess) listZombieProcess ;;
    killProcess) killProcess "$2" ;;
    ListWaitingProcess) listWaitingProcess ;;
    *) echo "Invalid command" ;;
esac

