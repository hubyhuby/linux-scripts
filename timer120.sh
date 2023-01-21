#!/bin/bash

interval=120 # interval in minutes
break_interval=6 # break interval in minutes

notifduration=20000

while true; do
    current_time=$(date +%T)
    echo "$current_time  :⌛  Starting Pomodoro session of $interval minutes"
    paplay /usr/share/sounds/freedesktop/stereo/complete.oga
    paplay /usr/share/sounds/freedesktop/stereo/complete.oga
    paplay /usr/share/sounds/freedesktop/stereo/complete.oga
    # start timer
    for ((i=interval; i>=0; i--)); do
      printf "\r\033[32m⌛ TIME REMAINING : %02d minutes \033[0m" $i
      sleep 60
    done

    # session is over
   current_time=$(date +%T)
    notify-send -t $notifduration "😴 Break Time" "$current_time: ☕ TAKE A BREAK NOW "

    printf "\r$current_time: 😴☕Session is over! Take a break.\n"
    echo "Press any key to start the break timer"
    read -n 1 -s
    
    
    # start break timer
    for ((i=break_interval; i>=0; i--)); do
      printf "\r BREAK timer remaining: %02d minutes" $i
      sleep 60
    done

    # break is over
    current_time=$(date +%T)
    notify-send -t $notifduration " $current_time :⌛ Break is OVER !"
    printf "\r$current_time :  ⌛ Break is over! Starting new Pomodoro session.\n"
  
done
