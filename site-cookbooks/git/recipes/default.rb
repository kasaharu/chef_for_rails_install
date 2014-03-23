#
# Cookbook Name:: git
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
log "Prepare Git"

%w{libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev}.each do |pkg|
  package pkg do
    action :install
  end
end

package "git-core" do
  action :install
end


