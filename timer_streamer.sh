#!/bin/bash
read -p "Press any key to start the timer..."

notify-send -t 39000 "🚀  Introduction" ""
echo "Starting timer 1: 40 seconds"
sleep 40
notify-send -t 19000 "🥸 Finishing introduction - 20s" ""

echo "Starting timer 2: 20 seconds"
sleep 20
notify-send -t 239000 " 1️⃣/3 💬" ""

echo "Starting timer 3: 240 seconds"
sleep 240
notify-send -t 239000 " 2️⃣/3 💬" ""

echo "Starting timer 4: 240 seconds"
sleep 240
notify-send -t 239000 " 3️⃣/3 💬" ""

echo "Starting timer 5: 240 seconds"
sleep 240
notify-send -t 30000 "CONCLUSION" ""

echo "All timers have completed"
notify-send -t 30000 " 🎉🎉🎉 BRAVO 🙌" ""
