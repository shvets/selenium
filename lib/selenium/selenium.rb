require 'open-uri'

class Selenium
  def download_file_to(uri, destination_file)
    print "  downloading #{uri}... "; $stdout.flush
    
    temp = destination_file + ".part"
    FileUtils.mkdir_p(File.dirname(destination_file))
    
    File.open(temp, "wb") do |out_file|
      open(uri) do |in_file| 
        done = false
        
        while(!done) do
          buffer = in_file.read(1024*1000)
          out_file.write(buffer)
            
          if buffer.nil? || buffer.size == 0
            done = true
          else
            print("#"); $stdout.flush             
          end
        end
      end
    end

    if File.open(temp).read(200) =~ /Access Denied/
      puts "\n\n*** Error downloading #{uri}, got Access Denied from S3."
      FileUtils.rm_rf(temp)
      exit
    end

     FileUtils.cp(temp, destination_file)
     FileUtils.rm_rf(temp)
     puts "\ndone!"
   end

   # unzip a .zip file into the directory it is located
   def unzip_file(path)
     print "unzipping #{path}..."; $stdout.flush
     source = File.expand_path(path)
     Dir.chdir(File.dirname(source)) do
       Zip::ZipFile.open(source) do |zipfile|
         zipfile.entries.each do |entry|
           FileUtils.mkdir_p(File.dirname(entry.name))
           begin
             entry.extract
           rescue Zip::ZipDestinationFileExistsError
           end
         end
       end
     end
   end
   
   def install source, destination
     download_file_to(source, destination)
     
     unzip_file(destination) if destination =~ /\.zip$/
   end
   
   def run jar_file
     runner = Runner.new

     runner.run jar_file    
   end
end

 