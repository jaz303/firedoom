module Firedoom::Backends::Java
  class SourceTree
    attr_reader :root, :packages
    
    def initialize(root)
      @root = root
      @packages = {}
    end
    
    def package(name)
      name = Package.sanitize_name(name)
      unless @packages.key?(name)
        pkg = Package.new(self, name)
        @packages[name] = pkg
      end
      yield @packages[name] if block_given?
      @packages[name]
    end
    
    def write!
      @packages.each { |name,pkg| pkg.write! }
    end
  end
end