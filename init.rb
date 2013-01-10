#-- encoding: UTF-8
# Post it plugin for Chiliproject
# Copyright (C) 2012  C2B SA
# Author: Arnauld NYAKU

require 'redmine'

# require all files in lib
Dir::foreach(File.join(File.dirname(__FILE__), 'lib')) do |file|
  next unless /\.rb$/ =~ file
  require file
end

Redmine::Plugin.register :chiliproject_post_it do
  name 'Chiliproject Post It'
  author 'C2B SA by Arnauld NYAKU'
  description ''
  version '2.0.0'
  url ''
  author_url 'mailto:arnauld.nyaku@c2bsa.com'
end