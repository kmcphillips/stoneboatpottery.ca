namespace :deploy do

  desc "Archive the project into a package to be deployed"
  task :package => :environment do
    raise "This is incomplete"
    
    include Archive::Tar
    require 'zlib'
    
    filename = "#{RAILS_ROOT}/tmp/stoneboat.tar.gz"

    puts "Creating archive: #{filename}..."

    files = Dir.entries(RAILS_ROOT).reject{|x| x =~ /^\..*|^tmp$/}
    
    Minitar.pack(files, Zlib::GzipWriter.new(File.open(filename, 'wb')))
    
    puts "  Done"
  end
end
