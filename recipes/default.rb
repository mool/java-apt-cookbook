#
# Cookbook Name:: java-apt
# Recipe:: default
#

apt_repository "java" do
  uri "http://ppa.launchpad.net/webupd8team/java/ubuntu"
  distribution "precise"
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "EEA14886"
end

directory "/var/cache/local/preseeding" do
  owner "root"
  group "root"
  mode 0755
  recursive true
end

execute "preseed java" do
  command "debconf-set-selections /var/cache/local/preseeding/java.seed"
  action :nothing
end

cookbook_file "/var/cache/local/preseeding/java.seed" do
  owner "root"
  group "root"
  mode 0600
  notifies :run, "execute[preseed java]", :immediately
end

package 'oracle-java7-installer'
