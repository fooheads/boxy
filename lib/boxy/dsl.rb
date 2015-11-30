module Boxy
  class Dsl
    def interpret(s)
      instance_eval(s)
    end
  
    # This is required to override Kernel.gem
    def gem(name, args = {})
      define_node('gem', name, args)
    end
  
    def define_node(type, name, args = {})
      puts "#{type} '#{name}', #{args.inspect}"
    end

    def include(url)

    end
  
    def method_missing(sym, *args)
      define_node(sym, args.shift, args)
    end
  end
end

if __FILE__ == $0
  Boxy::Dsl.new.interpret(File.read(ARGV[0]))
end
