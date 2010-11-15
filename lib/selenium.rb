require 'rubygems' unless RUBY_VERSION =~ /1.9.*/

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'fileutils'
require 'net/http'

require 'selenium/selenium'
require 'selenium/runner'
require 'selenium/jvm_options_probe'

require 'rbconfig'
WINDOZE = Config::CONFIG['host_os'] =~ /mswin|mingw|windows/

WINDOZE ? (require "zip/zipfilesystem") : (require 'zip/zip')
