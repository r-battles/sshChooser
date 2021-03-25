#!/bin/bash
function callSSH {
    if [ -z "$2" ]
    then
        ssh $1
    else     
        sshpass -p $2 ssh $1
    fi

}
function printSHHoutput {
    for (( i=0; i<${#lines[@]}; i++ )); do echo "[$i] : ${lines[i]}";     done
}
function readInputAndCallSSH {
    read -p "Choose your destiny: " i
    destiny=${lines[i]}
    key=$(cat ~/.ssh/sshpass.properties | grep "$destiny" | cut -d'=' -f2)
    callSSH $destiny $key
}

mapfile -t lines < <(grep '^Host' ~/.ssh/config | sed  -e  's/host //gI')
printSHHoutput
readInputAndCallSSH
