#!/bin/bash
# Get the action type (sum/sub/mul/div)
action=$1

# Read the two numbers from the user
read -p "please provide number1: " number1
read -p "please provide number2: " number2

# Perform the action based on the input
if [ "$action" == "sum" ]; then
    sum_of_number=$(($number1+$number2))
    echo "Total sum is $sum_of_number"

elif [ "$action" == "sub" ]; then
    sub_of_number=$(($number1-$number2))
    echo "Total sub is $sub_of_number"

elif [ "$action" == "mul" ]; then
    mul_of_number=$(($number1*$number2))
    echo "Total mul is $mul_of_number"

elif [ "$action" == "div" ]; then
    if [ "$number2" -ne 0 ]; then
        div_of_number=$(($number1/$number2))
        echo "Total div is $div_of_number"
    else
        echo "[ERROR] Division by zero is not allowed!"
    fi

else
    echo "[ERROR] Wrong action! Please select from this list (sum/sub/mul/div)"
fi

