#
# Cookbook Name:: ubuntu
# Recipe:: default :: nginx
#
# 
# Author - Roman Sereda
# e-mail sereda.roman@gmail.com
#
# Install nginx pakadge
package 'nginx' do
  action :remove
end


package 'software-properties-common' do
  action :install
end

execute "add ppa repositories" do
		command "add-apt-repository ppa:nginx/stable --yes"

		action :run
end

execute "apt-get update" do
		command "apt-get update"
		user "root"
		action :run
end



package 'nginx' do
  action :install
end

# create vhosts folder
directory "/var/www/" do
			owner "www-data"
			group "www-data"
			action :create
			mode "0755"
end

directory "/var/www/vhosts/" do
			owner "www-data"
			group "www-data"
			action :create
			mode "0755"
end

vhosts = node[:vhosts]
# create folder and file for all vhosts
vhosts.each do |vhost|
	directory "/var/www/vhosts/#{vhost}/" do
			owner "www-data"
			group "www-data"
			action :create
			mode "0775"
	end

	directory "/var/www/vhosts/#{vhost}/http_docs/" do
			owner "www-data"
			group "www-data"
			action :create
			mode "0775"
	end
	
	directory "/var/www/vhosts/#{vhost}/.ssh/" do
			owner "www-data"
			group "www-data"
			action :create
			mode "0775"
	end
	
	directory "/var/www/vhosts/#{vhost}/conf/" do
			owner "www-data"
			group "www-data"
			action :create
			mode "0775"
	end
	
	template "/etc/nginx/sites-available/#{vhost}" do
			source "nginx.conf.erb"
			owner "root"
			group "root"
			mode "0644"
			variables({
                           :vhost_name => vhost

                              })
			
	end
	
	
end

# create link  for active vhosts
active_vhosts=node[:active_vhosts]

active_vhosts.each do |vhost|
	execute "link vhost config" do
		command "ln -sf /etc/nginx/sites-available/#{vhost} /etc/nginx/sites-enabled/"

		action :run
	end
end
#incorect mast be unlink
file "/etc/nginx/sites-enabled/default" do
  action :delete
   #not_if { ::File.exists?("/etc/nginx/sites-enabled/default") }
end
			


service "nginx" do
  action :stop

end

service "nginx" do
  action :start

end
