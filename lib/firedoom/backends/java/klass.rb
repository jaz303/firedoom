module Firedoom::Backends::Java
  class Klass
    def self.sanitize_name(name)
      # TODO: ensure valid class name given
      name.to_s
    end
    
    attr_reader :package
    attr_reader :name
    
    def initialize(package, name)
      @package  = package
      @name     = self.class.sanitize_name(name)
      @access   = :default
      @abstract = false
      @imports  = []
      @defs     = []
    end
    
    def public!;    @access = :public;    end
    def private!;   @access = :private;   end
    def default!;   @access = :default;   end
    def abstract!;  @abstract = true;     end
    def concrete!;  @abstract = false;    end
    
    def import(klass_or_str)
      @imports << klass_or_str
    end
    
    def fully_qualified_name
      [package.name, name].join('.')
    end
    
    def path
      File.join(package.path, "#{name}.java")
    end
    
    def define(code, add_newline = true)
      @defs << code
    end
    
    def write!
      open_for_writing do |f|
        f.puts "package #{package.name};"
        f.puts
        
        unless @imports.empty?
          @imports.each do |i|
            if i.is_a?(Klass)
              f.puts "import #{i.fully_qualified_name};"
            else
              f.puts "import #{i};"
            end
          end
          f.puts
        end
        
        f.puts "#{modifiers}class #{name} {"
        @defs.each do |d|
          f.puts d.to_java.deindent.indent("    ")
          f.puts
        end
        f.puts "}"
      end
    end
    
  private
  
    def modifiers
      mod = []
      mod << "public" if @access == :public
      mod << "private" if @access == :private
      mod << "abstract" if @abstract
      out = mod.join(' ')
      out += ' ' unless out.blank?
      out
    end
  
    def open_for_writing(&block)
      p = path
      d = File.dirname(p)
      FileUtils.mkdir_p(d) unless File.directory?(d)
      File.open(p, "w", &block)
    end
  end
end