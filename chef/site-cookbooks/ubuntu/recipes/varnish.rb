#
# Cookbook Name:: ubuntu
# Recipe:: default :: varnish
#
# 
# Author - Roman Sereda
# e-mail sereda.roman@gmail.com
#
# Install latest varnish

package 'curl' do
  action :install

end

execute "get_GPG_key" do
		command "curl http://repo.varnish-cache.org/debian/GPG-key.txt | sudo apt-key add -"

		action :run
end

template "/etc/apt/source.list" do
			source "source.list.erb"
			owner "root"
			group "root"
			mode "0644"
			
			
	end

execute "apt-get update" do
		command "apt-get update"
		user "root"
		action :run
end

package 'varnish' do
  action :install

end

directory "/etc/varnish/include" do
			owner "root"
			group "root"
			action :create
			mode "0755"
end
#set config for start varnish demon
template "/etc/default/varnish" do
			source "varnish.etc.default.erb"
			owner "root"
			group "root"
			mode "0644"
			
   end   
#create a cach storage folder 
directory "/var/lib/varnish/mastercashe" do
			owner "varnish"
			group "varnish"
			action :create
			mode "0755"
end




vhosts = node[:vhosts]
#create defoult Varnish config file with inclute vhosts config
	template "/etc/varnish/default.vcl" do
			source "varnish.default.vlc.erb"
			owner "root"
			group "root"
			mode "0644"
			variables({
                           :vhostsd => vhosts

                              })
   end   
#Crete config file for each vhosts 
vhosts.each do |vhost|
	template "/etc/varnish/include/#{vhost}_.vcl" do
			source "varnish.vcl.erb"
			owner "root"
			group "root"
			mode "0644"
			variables({
                           :vhost_name => vhost

                              })
			
	end

	
end

service "varnish" do
  action :stop

end

service "varnish" do
  action :start

end


#	<% @vhostsd.each do |vhost| -%>
#	include "/etc/varnish/include/<%= vhost %>_.vcl";
#	<% end -%>
#
#

