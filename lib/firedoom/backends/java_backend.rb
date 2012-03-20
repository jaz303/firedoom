module Firedoom::Backends
  class JavaBackend < BaseBackend
    attr_accessor :root_package
    
  private
    def perform_generate
      @source = Java::SourceTree.new(output_dir)
      
      @classes = {}
      
      generate_class_stubs
      generate_world
      generate_systems
      
      @source.write!
    end
    
    def[](thing)
      @classes[thing]
    end
    
    def class_for(thing)
      @classes[thing]
    end
    
    def generate_class_stubs
      
      in_world_package do |pkg|
        @classes[world] = pkg.klass('World')
      end
      
      in_systems_package do |pkg|
        world.systems.each do |name, system|
          @classes[system] = pkg.klass("#{system.name}System")
        end
      end
      
    end
    
    def generate_world
      system_classes.each do |system, klass|
        world_class.import(klass)
      end
      
      system_fields = ""
      world.systems.each do |name, system|
        system_fields << "private final #{class_for(system).name} #{system_field_name(system)};\n"
      end
      
      init = "public void init() {\n"
      world.systems.each do |name, system|
        init << "    #{system_field_name(system)} = new #{class_for(system).name}(this);\n"
      end
      init << "}\n"
      
      update = "public void update() {\n"
      world.active_systems.each do |system|
        update << "    #{system_field_name(system)}.update();\n"
      end
      update << "}\n"
      
      world_class.define(system_fields)
      world_class.define(init)
      world_class.define(update)
    end
    
    def generate_systems
      system_classes.each do |system, klass|
        klass.import(world_class)
        klass.define <<-CODE
          private final #{world_class.name} world;
      
          public #{klass.name}(#{world_class.name} world) {
              this.world = world;
          }
        
          public #{world_class.name} getWorld() {
              return this.world;
          }
        CODE
        
        unless system.inert?
          klass.define <<-CODE
            public void update() {
            }
          CODE
        end
      end
    end
    
    def world_class
      @classes[world]
    end
    
    def system_classes
      world.systems.inject({}) { |hsh,(name,system)| hsh[system] = class_for(system); hsh }
    end
    
    def in_world_package(&block)
      @source.package(root_package) do |root_package|
        yield root_package
      end
    end
    
    def in_systems_package(&block)
      @source.package(root_package) do |root_package|
        root_package.package('systems') do |systems_package|
          yield systems_package
        end
      end
    end
  
    def preflight
      super
      raise "root_package is not set" if @root_package.nil?
    end
    
    def system_field_name(system)
      "#{system.name[0..0].downcase}#{system.name[1..-1]}System"
    end
  end
end