require "pathname"


module Pagechanger
  class File
  
    def initialize config, filepath
      @config = config
      @filename = Pathname.new(filepath).basename
      @fullpath = filepath
    end
  
    def can_process
      @file_str = File.read @fullpath
      @config.criteria.each do |c|
        pattern = Regexp.new c
        search = @file_str.match pattern
        if search
          return true
        end
      end
      puts "Skipping file #{@fullpath} as it does not match criteria."
      return false
    end
    
    def is_exception
      # check and see if the filename or the full path (with filename) is in
      # the exceptions
      if @config.exceptions.include? @filename or @config.exceptions.include? @fullpath
        puts "Skipping file #{@fullpath} as it is an exception."
        return true
      end
      return false
    end
    
    def process
      if not @file_str
        @file_str = File.read @fullpath
      end
      puts "Processing file #{@fullpath}."
      process_removals @config.remove
      process_replacements @config.replace
    end
    
    
    private
    
    def process_removals removals
      removals.each do |r|
        pattern = Regexp.new r
        @file_str = @file_str.sub pattern, ''
      end
    end
    
    def process_replacements replacements
      replacements.each do |r|
        pattern = Regexp.new r.find
        @file_str = @file_str.sub pattern, r.replace
      end
  end
end