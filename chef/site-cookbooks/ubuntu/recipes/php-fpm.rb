#
# Cookbook Name:: ubuntu
# Recipe:: default :: nginx
#
# 
# Author - Roman Sereda
# e-mail sereda.roman@gmail.com
#
# Install php-fpm pakadge


%w[php5-fpm php-apc mysql-client php5-mysql php5-curl imagemagick php-pear graphicsmagick libgraphicsmagick1-dev php5-gd].each do |pack|
  package pack
end






#sudo pear install Calendar
#Failed to download pear/Calendar within preferred state "stable", latest release is version 0.5.5, stability "beta", use "channel://pear.php.net/Calendar-0.5.5" to install
#install failed

template "/etc/php5/fpm/php.ini" do
			source "php.ini.erb"
			owner "root"
			group "root"
			mode "0644"
			
end

service "php5-fpm" do
  action :restart
end




