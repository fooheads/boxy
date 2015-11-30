require 'open-uri'
require_relative 'command'

module Boxy
  class Dsl
    def interpret(url)
      @commands = []
      instance_eval(open(url).read)
      @commands
    end
  
  private

    def method_missing(sym, *args)
      add_command(sym, args.shift, args.shift.to_h)
    end

    def include(url)
      Dsl.new.interpret(url)
    end

    # This is required to override Kernel.gem
    def gem(name, args = {})
      add_command(:gem, name, args)
    end
  
    def add_command(type, name, options)
      @commands << Command.new(type, name, options)
    end

  end
end

