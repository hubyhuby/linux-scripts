echo Disk RAID tests. [UU] = 2 x HDD Up and alive ! :
cat /proc/mdstat
echo HDD Smart :
sudo smartctl -a /dev/sda > smart-results.txt
sudo smartctl -a /dev/nvme0n1p2 > smart-resultsB.txt
echo -------------------------------------------------------------------
echo DONE!\n RESULTS :
cat smart-results.txt
cat smart-resultsB.txt
