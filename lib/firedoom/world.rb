module Firedoom
  class World
    attr_reader :systems
    
    def initialize
      @systems = {}
    end
    
    def system(name)
      name = System.sanitize_name(name)
      unless @systems.key?(name)
        sys = System.new(self, name)
        @systems[name] = sys
      end
      yield @systems[name] if block_given?
    end
    
    def active_systems
      @systems.values.select { |s| s.active? }
    end
  end
end