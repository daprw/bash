# This is something thrown together quickly to get specific "exceeded" statistics from ethtool -S output sent to a log file.
# This is a companion tool that should be used if you are testing theoretical pps / bandwidth limits with a tool like iperf.
# You want to have the script running before you start your testing to ensure you have data prior to the test and after to compare to.
#
# The idea is to get a timestamp associated with the *exceeded statistics pulled by ethtool which include:
#     bw_in_allowance_exceeded
#     bw_out_allowance_exceeded
#     pps_allowance_exceeded
#     conntrack_allowance_exceeded
#     linklocal_allowance_exceeded
#
# This is not optimized and was used to quickly test bandwidth limits between EC2 instances and PPS limits.

echo "Ctrl+C to exit the script when you have finished the testing"
read -p "Interface name: " intName

while true
do 
    echo "$(date): " >> ethtool_stats.log ; echo "$(ethtool -S $intName | grep exceeded)" >> ethtool_stats.log; sleep 3;
    echo "$(date): " >> sys_net_stats.log ; echo "$(ethtool -S $(ls /sys/class/net|grep -v lo)|grep 'exceed')" >> sys_net_stats.log; sleep 3;
    #echo "$(date): " >> netlink.log ; echo "$(cat /proc/net/netlink)" >> netlink.log; sleep 2;
done

