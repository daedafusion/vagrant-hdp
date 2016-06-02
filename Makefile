all: prep hostname install setup keys start

install:
	sudo wget -nv http://public-repo-1.hortonworks.com/ambari/ubuntu14/2.x/updates/2.2.2.0/ambari.list -O /etc/apt/sources.list.d/ambari.list
	sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com B9733A7A07513CAD
	sudo apt-get update
	sudo apt-get -y upgrade
	sudo apt-get -y install ambari-server

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
	sudo apt-get -y install ntp
	sudo service ntp start
	sudo chkconfig ntp on
	#sudo service iptables stop
	#sudo chkconfig iptables off

filters:
	sudo cp hbase-filters-1.0-SNAPSHOT.jar /filters/.

mr:
	rm -rf trinity-core-1.0-SNAPSHOT
	unzip trinity-core-1.0-SNAPSHOT-hadoop-classpath.zip
	cd trinity-core-1.0-SNAPSHOT && ./scripts/push_mr.sh /argos/trinity

getdeps:
	cp ../knowledge/trinity/trinity-mr/target/trinity-mr-1.0-SNAPSHOT-hadoop-classpath.zip .
	cp ../commons/hbase-filters/target/hbase-filters-1.0-SNAPSHOT.jar .
