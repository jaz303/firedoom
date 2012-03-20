module Firedoom::Backends
  class JavaBackend < BaseBackend
    attr_accessor :root_package
    
  private
    def perform_generate
    
    end
  
    def preflight
      super
      raise "root_package is not set" if @root_package.nil?
    end
  end
end