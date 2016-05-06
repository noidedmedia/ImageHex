# frozen_string_literal: true
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be
# available to Rake.
require 'rdoc/task'

RDoc::Task.new :documentation do |rdoc|
  rdoc.rdoc_files.include("README.rdoc", "app/**/*.rb", "lib/**/*.rb", "config/locales/**/*.rdoc")
  rdoc.rdoc_dir  = "doc"
  rdoc.main      = "README.rdoc"
  rdoc.title     = "ImageHex Documentation"
  rdoc.options << "--all"
end

RDoc::Task.new :doc_coverage do |rdoc|
  rdoc.rdoc_files.include("app/**/*.rb", "lib/**/*.rb", "config/locales/**/*.rdoc")
  rdoc.rdoc_dir  = "doc"
  rdoc.main      = "README.rdoc"
  rdoc.title     = "ImageHex Documentation"
  rdoc.options   << "-C"
  rdoc.options   << "--all"
end

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks
