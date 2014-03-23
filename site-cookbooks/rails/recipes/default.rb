#
# Cookbook Name:: rails
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
log "Prepare Rails"


bash "gem_update 2" do
  code <<-EOC
    source /home/vagrant/rbenv.sh
    gem update --system
    gem install rails
  EOC
end
