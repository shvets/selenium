require 'rubygems' unless RUBY_VERSION =~ /1.9.*/

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'fileutils'
require 'net/http'

if RUBY_PLATFORM =~ /windows/
  require "zip/zipfilesystem"
else
  require 'zip/zip'  
end

require 'selenium/selenium'
require 'selenium/runner'
require 'selenium/jvm_options_probe'