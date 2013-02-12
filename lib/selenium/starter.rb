require 'selenium/version'

module Selenium
  class Starter
    SELENIUM_SERVER_VERSION = "2.28.0"

    USAGE= <<-TEXT
    Usage:
      selenium help    - this help
      selenium install - installs selenium
      selenium         - runs the selenium server
    TEXT

    attr_reader :wrapper

    def initialize
      @wrapper = JarWrapper.new
    end

    def run params
      install_dir = ENV['HOME'] + "/.selenium/assets"

      source   = "http://selenium.googlecode.com/files/selenium-server-#{SELENIUM_SERVER_VERSION}.zip"
      target   = install_dir + "/selenium-server-#{SELENIUM_SERVER_VERSION}.zip"
      jar_file = install_dir + "/selenium-#{SELENIUM_SERVER_VERSION}/selenium-server-standalone-#{SELENIUM_SERVER_VERSION}.jar"

      param = params.length == 0 ? "" : params.first

      case param
        when /(-v)|(--version)/ then
          puts "Version: #{Selenium::VERSION}"
        when 'install' then
          wrapper.install source, target
          puts ""
        when 'help' then
          puts USAGE and return
        else
          wrapper.jar_file = jar_file
          wrapper.java_opts = []
          wrapper.run params.nil? ? [] : params
      end
    end
  end
end
