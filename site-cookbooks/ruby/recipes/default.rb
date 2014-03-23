#
# Cookbook Name:: ruby
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
log "Prepare Ruby"

package "ruby" do
  action :purge
end

%w{build-essential curl zlib1g-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev sqlite3 libsqlite3-dev nodejs make gcc ncurses-dev libgdbm-dev libdb4.8-dev libffi-dev tk-dev}.each do |pkg|
  package pkg do
    action :install
  end
end

git "/home/vagrant/.rbenv" do
  repository "git://github.com/sstephenson/rbenv.git"
  reference "master"
  action :sync
  user "vagrant"
  group "vagrant"
end


%w{/home/vagrant/.rbenv/plugins}.each do |dir|
  directory dir do
    action :create
    user "vagrant"
    group "vagrant"
  end
end

git "/home/vagrant/.rbenv/plugins/ruby-build" do
  repository "git://github.com/sstephenson/ruby-build.git"
  reference "master"
  action :sync
  user "vagrant"
  group "vagrant"
end

log "ruby checkout done"


bash "insert_line_rbenvpath" do
  environment "HOME" => '/home/vagrant'
  code <<-EOS
    echo 'export PATH="/home/vagrant/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    chmod 777 ~/.bashrc
    source ~/.bashrc
  EOS
end


template "rbenv.sh" do
  owner  "vagrant"
  group  "vagrant"
  mode   "0777"
  path   "/home/vagrant/rbenv.sh"
  source "rbenv.sh.erb"
end


bash "install ruby" do
  user "vagrant"
  group "vagrant"
  environment "HOME" => '/home/vagrant'
  code <<-EOS
    source /home/vagrant/rbenv.sh
    rbenv install 2.0.0-p0
    rbenv rehash
    rbenv global 2.0.0-p0
  EOS
end

