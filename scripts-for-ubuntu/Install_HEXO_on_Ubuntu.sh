sudo ln -s /usr/bin/nodejs /usr/bin/node
sudo apt-get install git
sudo npm install -g hexo
hexo init ss
cd ss && npm install
sudo npm install -g grunt
#sudo npm install -g grunt-cli
npm install hexo-deployer-git --save
npm install hexo-admin --save
npm install hexo-generator-feed --save
hexo server &