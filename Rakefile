# Rakefile for selenium

task :default => :gemspec

begin
  require 'bundler'
  
  begin
    require 'jeweler'
    
    Jeweler::Tasks.new do |gemspec|
      gemspec.name = "selenium"
      gemspec.summary = "Gem wrapper for selenium server (Summary)."
      gemspec.description = "Gem wrapper for selenium server."
      gemspec.email = "alexander.shvets@gmail.com"
      gemspec.homepage = "http://github.com/shvets/selenium"
      gemspec.authors = ["Alexander Shvets"]
      gemspec.files = FileList["CHANGES", "selenium.gemspec", "Rakefile", "README", "VERSION",
                               "lib/**/*", "bin/**/*"] 

      gemspec.executables = ['selenium']
      gemspec.requirements = ["none"]
      gemspec.bindir = "bin"
    
      gemspec.add_bundler_dependencies
      
      gemspec.post_install_message = <<-TEXT

      -------------------------------------------------------------------------------

      Please now run:

        $ selenium install

      NB. This will download jars that this gem needs to run from the internet.
      It will put them into ~/.selenium/assets.

      -------------------------------------------------------------------------------
TEXT
      
    end
  rescue LoadError
    puts "Jeweler not available. Install it s with: [sudo] gem install jeweler"
  end
rescue LoadError
  puts "Bundler not available. Install it s with: [sudo] gem install bundler"
end


desc "Release the gem"
task :"release:gem" do
  %x(
      rake gemspec
      rake build
      rake install
      git add .  
  )  
  puts "Commit message:"  
  message = STDIN.gets

  version = "#{File.open(File::dirname(__FILE__) + "/VERSION").readlines().first}"

  %x(
    git commit -m "#{message}"
    
    git push origin master

    gem push pkg/selenium-#{version}.gem      
  )
end

