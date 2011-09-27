# Author::    Michael Cowden
# Copyright:: MigraineLiving.com
# License::   Distributed under the same terms as Ruby

class FlotomaticGenerator < Rails::Generators::Base
  desc "Description: Copies flotomatic javascript directory and css file to the proper application public directory structure, as needed by flotmatic."
  def self.source_root
    @source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
  end
  
  def move_files
    copy_file 'flotomatic/css/flotomatic.css', "public/stylesheets/flotomatic.css"
    directory "flotomatic/javascripts", 'public/javascripts/flotomatic'
  end
end
