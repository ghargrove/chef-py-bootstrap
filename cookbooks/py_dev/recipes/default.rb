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

## Setup the requirements file
cookbook_file '/home/vagrant/requirements.txt' do
    source 'requirements.txt'
    owner  'vagrant'
    group  'vagrant'
    mode   0664
end

## Install py
python_runtime '3'

python_virtualenv '/home/vagrant/py_dev' do
    user  'vagrant'
    group 'vagrant'
end

pip_requirements '/home/vagrant/requirements.txt' do
    cwd '/home/vagrant/py_dev'
    virtualenv '/home/vagrant/py_dev'
end

cookbook_file '/home/vagrant/py_dev/jupyter' do
    source 'jupyter.txt'
    owner 'vagrant'
    group 'vagrant'
    mode 0774
end

directory '/home/vagrant/py_dev/notebooks' do
    owner 'vagrant'
    group 'vagrant'
    mode 0775
end
