#
# Cookbook Name:: py_dev
# Recipe:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

## Install deps
deps = %w(build-essential curl git-core libssl-dev libffi-dev libreadline-dev python3-dev python-dev python3-tk)
deps.each do |i|
    package i
end

## Download & install anaconda
remote_file '/home/vagrant/anaconda.sh' do
  source node['anaconda']['url']
  owner 'vagrant'
  group 'vagrant'
  mode  0777
end

execute 'Install anaconda' do
  cwd '/home/vagrant'
  command '/bin/bash anaconda.sh -b -p /home/vagrant/anaconda3'
  not_if 'type anaconda >/dev/null 2>&1'
end

execute 'update-bashrc' do
  command %(echo 'export PATH="/home/vagrant/anaconda3/bin:$PATH"' >> /home/vagrant/.bashrc)
  not_if 'type anaconda >/dev/null 2>&1'
end

## Setup the requirements file
cookbook_file '/home/vagrant/requirements.txt' do
    source 'requirements.txt'
    owner  'vagrant'
    group  'vagrant'
    mode   0664
end

execute 'conda-install' do
  command '/home/vagrant/anaconda3/bin/conda install --file /home/vagrant/requirements.txt'
end

## Setup a notebook environment
cookbook_file '/home/vagrant/jupyter' do
    source 'jupyter.txt'
    owner 'vagrant'
    group 'vagrant'
    mode 0774
end

directory '/home/vagrant/notebooks' do
    owner 'vagrant'
    group 'vagrant'
    mode 0775
end
