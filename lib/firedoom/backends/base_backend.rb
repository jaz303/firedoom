module Firedoom::Backends
  class BaseBackend
    attr_accessor :delete_before
    attr_accessor :world
    attr_accessor :output_dir
    
    def initialize
      @delete_before  = false
      @world          = nil
      @output_dir     = nil
    end
    
    def generate!
      preflight
      delete_existing if @delete_before
      create_output_dir
      perform_generate
    end
    
  private
  
    def preflight
      raise "world is not set" if @world.nil?
      raise "output_dir is not set" if @output_dir.nil?
    end
    
    def delete_existing
      FileUtils.rm_rf(@output_dir) if File.exists?(@output_dir)
    end
    
    def create_output_dir
      FileUtils.mkdir_p(@output_dir) unless File.directory?(@output_dir)
    end
    
    def perform_generate
      raise "implement me!"
    end
  end
end