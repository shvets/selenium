class Selenium
  def download_file_to(uri, destination_file)
    connection = Net::HTTP

     print "  downloading #{uri}... "; $stdout.flush
     temporary_target  = destination_file + ".part"
     FileUtils.mkdir_p(File.dirname(destination_file))
     File.open(temporary_target, "wb") do |write_out|
       write_out.print connection.get(URI.parse(uri))
     end

     if File.open(temporary_target).read(200) =~ /Access Denied/
       puts "\n\n*** Error downloading #{uri}, got Access Denied from S3."
       FileUtils.rm_rf(temporary_target)
       exit
     end

     FileUtils.cp(temporary_target, destination_file)
     FileUtils.rm_rf(temporary_target)
     puts "done!"
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

 