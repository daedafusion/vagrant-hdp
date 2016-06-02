all: prep repo hostname update install setup keys start

repo:
	sudo cp ambari.repo /etc/yum.repos.d/ambari.repo

update:
	sudo yum update

install:
	sudo yum install ambari-server

setup:
	sudo ambari-server setup

start:
	sudo ambari-server start

keys:
	ssh-keygen -t rsa -C "ambari"
	cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
	echo "Private Key For Ambari Setup"
	cat ~/.ssh/id_rsa

hostname:
	sudo hostname hdp
	echo "192.168.33.10     hdp" | sudo tee -a /etc/hosts

prep:
	sudo yum install ntp
	sudo service ntpd start
	sudo chkconfig ntpd on
	sudo service iptables stop
	sudo chkconfig iptables off

filters:
	sudo cp hbase-filters-1.0-SNAPSHOT.jar /filters/.

mr:
	rm -rf trinity-core-1.0-SNAPSHOT
	unzip trinity-core-1.0-SNAPSHOT-hadoop-classpath.zip
	cd trinity-core-1.0-SNAPSHOT && ./scripts/push_mr.sh /argos/trinity

getdeps:
	cp ../knowledge/trinity/trinity-mr/target/trinity-mr-1.0-SNAPSHOT-hadoop-classpath.zip .
	cp ../commons/hbase-filters/target/hbase-filters-1.0-SNAPSHOT.jar .
