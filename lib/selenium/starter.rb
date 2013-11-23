require 'jar_wrapper'
require 'selenium/version'

module Selenium
  class Starter
    SELENIUM_SERVER_VERSION = "2.37.0"

    USAGE= <<-TEXT
    Usage:
      selenium help    - this help
      selenium install - installs selenium
      selenium         - runs the selenium server
    TEXT

    attr_reader :wrapper

    def initialize
      @wrapper = JarWrapper::Runner.new
    end

    def run params
      selenium_version = SELENIUM_SERVER_VERSION

      param = params.length == 0 ? "" : params.first

      case param
        when /(-v)|(--version)/ then
          puts "Version: #{Selenium::VERSION}"
        when 'install' then
          source   = "http://selenium.googlecode.com/files/selenium-server-#{selenium_version}.zip"
          target   = install_dir + "/selenium-server-#{selenium_version}.zip"

          wrapper.install source, target
          puts ""
        when 'help' then
          puts USAGE and return
        else
          jar_file = install_dir + "/selenium-#{selenium_version}/selenium-server-standalone-#{selenium_version}.jar"

          wrapper.jar_file = jar_file
          wrapper.java_opts = []
          wrapper.run params.nil? ? [] : params
      end
    end

    def install_dir
      ENV['HOME'] + "/.selenium/assets"
    end
  end
end
