$:.unshift(File.dirname(__FILE__))

require 'fileutils'
require 'active_support'
require 'active_support/inflector'
require 'active_support/core_ext'

require 'firedoom/core_ext/string'

module Firedoom
  autoload :System,             'firedoom/system'
  autoload :World,              'firedoom/world'
  
  module Backends
    autoload :BaseBackend,      'firedoom/backends/base_backend'
    autoload :JavaBackend,      'firedoom/backends/java_backend'
    
    module Java
      autoload :Klass,          'firedoom/backends/java/klass'
      autoload :Package,        'firedoom/backends/java/package'
      autoload :SourceTree,     'firedoom/backends/java/source_tree'
    end
  end
end