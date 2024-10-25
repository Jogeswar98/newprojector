#!/bin/bash

addTeam() {
    sudo groupadd $1
    echo "Team (group) $1 added."
}

addUser() {
    sudo useradd -m -d /home/$1 -g $2 $1
    echo "User $1 added to team $2."
    
    sudo chmod 750 /home/$1
    
    
    sudo mkdir /home/$1/team /home/$1/ninja
    
    
    sudo chmod 770 /home/$1/team  # Full access for same team members
    sudo chmod 777 /home/$1/ninja # Full access for all ninjas (everyone)
    
    echo "Team and Ninja directories created with appropriate permissions."
}

changeShell() {
    sudo usermod --shell $2 $1
    echo "Shell for user $1 changed to $2."
}

changePasswd() {
    sudo passwd $1
}

delUser() {
    sudo userdel -r $1
    echo "User $1 deleted."
}

delTeam() {
    sudo groupdel $1
    echo "Team (group) $1 deleted."
}

lsUsers() {
    cut -d: -f1 /etc/passwd
}
lsTeams() {
    cut -d: -f1 /etc/group
}

case "$1" in
    addTeam)
        addTeam $2
        ;;
    addUser)
        addUser $2 $3
        ;;
    changeShell)
        changeShell $2 $3
        ;;
    changePasswd)
        changePasswd $2
        ;;
    delUser)
        delUser $2
        ;;
    delTeam)
        delTeam $2
        ;;
    ls)
        if [ "$2" = "User" ]; then
            lsUsers
        elif [ "$2" = "Team" ]; then
            lsTeams
        fi
        ;;
    *)
        echo "Usage: $0 {addTeam|addUser|changeShell|changePasswd|delUser|delTeam|ls User|ls Team}"
        ;;
esac

