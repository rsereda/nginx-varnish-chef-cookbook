Chef kuchen for deployment web enviromants.


Requrements

1. RVM
install process
#\curl -sSL https://get.rvm.io | bash

2. ruby 
#rvm install 2.1.0-rc1
#rvm use 2.1.0-rc1
3. chef-solo
#gem install knife-solo

Get latest chef-solo kuchen with cookbook and reciept
#git clone git@github.com:rsereda/nginx-varnish-chef-cookbook.git

#cd chef
initial install chef on destination server
#knife solo prepare user@servername nodes/ubuntu.json

Deploy process 

#knife solo cook user@servername nodes/ubuntu.json

