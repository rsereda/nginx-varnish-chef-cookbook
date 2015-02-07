#
# Cookbook Name:: ubuntu
# Recipe:: default :: git-core
#
# 
# Author - Roman Sereda
# e-mail sereda.roman@gmail.com
#
# Install git-core pakadge

package 'git-core' do
  action :install
  options "--force-yes"
end
