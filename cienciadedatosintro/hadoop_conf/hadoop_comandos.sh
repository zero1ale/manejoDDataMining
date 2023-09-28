./hdfs namenode -format
cd /home/jose/bd/hadoop/sbin/
./start-dfs.sh
./start-yarn.sh
./mr-jobhistory-daemon.sh start historyserver
cd /home/jose/bd/hadoop/bin/
./yarn jar /home/jose/bd/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.7.jar pi 4 10

./hdfs dfs -mkdir /user/hive
./hdfs dfs -mkdir /user/hive/warehouse
./hdfs dfs -put /home/jose/data/chicago/* /user/hive/warehouse
./hdfs dfs -chmod g+w /user/hive/warehouse
schematool -dbType derby -initSchema

