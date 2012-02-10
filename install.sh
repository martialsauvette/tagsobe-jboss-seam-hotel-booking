#!/bin/sh


sudo yum -y install git
sudo yum -y install java-1.6.0-openjdk-devel
#sudo yum -y install tomcat6-webapps
sudo yum -y install mysql
sudo yum -y install mysql-server
sudo yum -y install ant


git clone git://github.com/martailsauvette/tagbrowser.git
cd tagbrowser
ant
cd

sudo service mysqld start
mysqladmin -u root create tagsobe
mysql -u root tagsobe -e "grant usage on *.* to tagsobe@localhost identified by 'tagsobe'"
mysql -u root tagsobe -e "grant all privileges on tagsobe.* to tagsobe@localhost"

cd /srv
sudo wget http://sourceforge.net/projects/jboss/files/JBoss/JBoss-4.2.3.GA/jboss-4.2.3.GA-jdk6.zip/download -O jboss.zip
sudo unzip jboss.zip
sudo chmod -R 777 /srv


#export JBOSS_HOME=/srv/jboss-4.2.3.GA

cd 
wget http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.18.zip/from/http://mysql.mirrors.ovh.net/ftp.mysql.com/ -O mysql-connector.zip
unzip mysql-connector.zip mysql-connector-java-5.1.18/mysql-connector-java-5.1.18-bin.jar
cp mysql-connector-java-5.1.18/mysql-connector-java-5.1.18-bin.jar /srv/jboss-4.2.3.GA/server/default/lib/
cd

wget http://sourceforge.net/projects/jboss/files/JBoss%20Seam/2.2.2.Final/jboss-seam-2.2.2.Final.zip/download -O seam.zip
unzip seam.zip
cd jboss-seam-2.2.2.Final/examples
find . -type d  | xargs rm -rf
git clone git://github.com/martailsauvette/tagsobe-jboss-seam-hotel-booking.git

cd tagsobe-jboss-seam-hotel-booking
mv build.properties ../..
ant

cd
sudo sh /srv/jboss-4.2.3.GA/bin/run.sh &



sleep 30


cd ~/tagbrowser/dist
java -jar tagsobe.jar http://localhost:8080/seam-booking/home.seam

sudo sh /srv/jboss-4.2.3.GA/bin/shutdown.sh localhost

cd


