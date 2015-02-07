#
# Cookbook Name:: ubuntu
# Recipe:: useradd
#
# 
# Author - Roman Sereda
# e-mail sereda.roman@gmail.com
#

username = node[:useradd][:username]
passwd = node[:useradd][:password]
home = node[:useradd][:home]
ssh_keys = node[:useradd][:ssh_keys]

	user"#{username}" do
		
		#add user with user name
		home "#{home}"
		password "#{passwd}"
		shell "/bin/bash"
		action :create 
	end
	group "#{username}" do
		#add group 
		action :create
		members "#{username}"
		append true
	end
	directory "#{home}" do
		owner "#{username}"
		group "#{username}"
		mode "0744"
		action :create
	end
	directory "#{home}/.ssh" do
		owner "#{username}"
		group "#{username}"
		mode 0744
		action :create
	end
	
	template "/home/#{username}/.ssh/authorized_keys" do
      	owner "#{username}"
		group "#{username}"
		mode 0400
		source "authorized_keys.erb"
		variables     :sshkeys => ssh_keys
	end
	
	
	group "www-data" do
		action :modify
		members "#{username}"
		append true
	end
