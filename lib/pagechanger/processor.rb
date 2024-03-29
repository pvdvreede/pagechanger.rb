require "pagechanger/file"
require "yaml"

module Pagechanger
  class Processor
    
    def initialize config_filename, dir, recursive
      @config = get_config config_filename
      @dir = dir
      @recursive = recursive
    end
    
    def process
      #start_time = 
      file_sets = load_files @dir, @config, @recursive
      file_sets.each do |file_set|
        Pagechanger::File.print_msg "Processing file set #{file_set.name}."
        file_set.each do |file|
          unless file.is_exception and not file.can_process
            file.process
          end
        end
      end
    end
      
    def get_config config_filename
      yaml.load_file config_filename
    end
    
    def load_files dir, config, recursive
      file_sets = Array.new
      config.each do |search|
        # Get all the files from the dir in the file mask
        if recursive
          search_path = File.join dir, '/**/', search.mask
        else
          search_path = File.join dir, search.mask
        end
        files = Array.new
        Dir[search_path].each do |file|
          files << Pagechanger::File.new(search, file)
        end
        file_sets << files
      end
      return file_sets
    end
  end
end