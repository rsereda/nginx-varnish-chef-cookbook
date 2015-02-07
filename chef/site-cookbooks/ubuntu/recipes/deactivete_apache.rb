#
# Cookbook Name:: ubuntu
# Recipe:: default :: deactivete_apache
#
# 
# Author - Roman Sereda
# e-mail sereda.roman@gmail.com
#
#Remove Apache webserver if exist
#package 'apache2.2-bin' do
#  action :purge
#  options "--force-yes"
#end

file "/etc/init.d/apache2" do

  mode "0644"
  action :create
end
