#
# Cookbook Name:: ubuntu
# Recipe:: default :: lsyncd
#
# 
# Author - Roman Sereda
# e-mail sereda.roman@gmail.com
#
# Install lsyncd pakadge

vhosts = node[:vhosts]

directory "/etc/lsyncd/" do
			owner "root"
			group "root"
			action :create
			mode "0755"
end

directory "/var/log/lsyncd/" do
			owner "root"
			group "root"
			action :create
			mode "0755"
end


package 'lsyncd' do
  action :install
end




template "/etc/lsyncd/lsyncd.conf.lua" do
			source "lsyncd.erb"
			owner "root"
			group "root"
			mode "0644"
			variables({
                           :vhosts => vhosts

                              })
			
end

template "/etc/lsyncd/lsyncd.exclude" do
			source "lsyncd.exclude.erb"
			owner "root"
			group "root"
			mode "0644"
			variables({
                           :vhosts => vhosts

                              })
			
end

service "lsyncd" do
  action :stop

end

service "lsyncd" do
  action :start

end
