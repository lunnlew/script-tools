sudo apt-get update
sudo apt-get upgrade
 
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
 
sudo apt-get install oracle-java7-installer


wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

echo "deb https://packages.elastic.co/elasticsearch/2.x/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list

sudo apt-get update && sudo apt-get install elasticsearch

sudo update-rc.d elasticsearch defaults 95 10


sudo /etc/init.d/elasticsearch restart
curl -X GET 'http://0.0.0.0:9200'


sudo /usr/share/elasticsearch/bin/plugin install license
sudo /usr/share/elasticsearch/bin/plugin install marvel-agent


wget https://download.elastic.co/kibana/kibana/kibana_4.5.0_amd64.deb
sudo dpkg -i kibana_4.5.0_amd64.deb


/opt/kibana/bin/kibana plugin --install elasticsearch/marvel/latest

#sudo /etc/init.d/kibana restart
/opt/kibana/bin/kibana 

curl -X GET 'http://0.0.0.0:5601/app/marvel'

wget https://download.elastic.co/logstash/logstash/packages/debian/logstash_2.3.2-1_all.deb
sudo dpkg -i logstash_2.3.2-1_all.deb

/opt/logstash/bin/logstash -f test.conf