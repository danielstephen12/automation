redis-cli -h 10.180.59.240 -p 10002 -a 'BLoo3Pa55w$d' cluster nodes | grep master | awk {'print $2'} | cut -f1 -d '@' > master_hosts.txt
pwd="BLoo3Pa55w\$d"
DB="josh-prod-cache-user-recommendation"
rm flushdb_${DB}_script.sh

while IFS= read -r string ; do
 host=$(echo "$string" | cut -d ":" -f 1)
 port=$(echo "$string" | cut -d ":" -f 2)
 echo "redis-cli -h $host -p $port -a '$pwd' flushdb async" >> flushdb_${DB}_script.sh
 chmod 755 flushdb_${DB}_script.sh
done< master_hosts.txt 
