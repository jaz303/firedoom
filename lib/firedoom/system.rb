module Firedoom
  class System
    def self.sanitize_name(name)
      name.to_s
    end
    
    attr_reader :world
    attr_reader :name
    
    def initialize(world, name)
      @world = world
      @name = self.class.sanitize_name(name)
    end
  end
end