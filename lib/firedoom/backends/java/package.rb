module Firedoom::Backends::Java
  class Package
    def self.sanitize_name(name)
      # TODO: ensure valid package name given
      name.to_s
    end
    
    attr_reader :source_tree
    attr_reader :name
    
    def initialize(source_tree, name)
      @source_tree = source_tree
      @name = name
      @classes = {}
    end
    
    def package(sub_package_name, &block)
      source_tree.package([name, sub_package_name].join('.'), &block)
    end
    
    def klass(name)
      name = Klass.sanitize_name(name)
      unless @classes.key?(name)
        klazz = Klass.new(self, name)
        @classes[name] = klazz
      end
      yield @classes[name] if block_given?
      @classes[name]
    end
    
    def path
      File.join(source_tree.root, name.gsub('.', '/'))
    end
    
    def write!
      @classes.each { |name,klass| klass.write! }
    end
  end
end