class String
  def to_java
    self
  end
  
  def deindent
    lines = split("\n")
    ind = lines.inject(20000) { |m,ln|
      if ln.strip.length == 0
        m
      else
        (ln =~ /^( +)/) ? ($1.length < m ? $1.length : m) : (m)
      end
    }
    gsub(/^#{' ' * ind}/m, '')
  end
  
  def indent(char, mul = 1)
    self.gsub(/^/m, char * mul)
  end
end