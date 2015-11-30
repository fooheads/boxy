require 'open-uri'
require 'uri'
require_relative 'command'

module Boxy
  class Dsl
    def self.interpret(url)
      Dsl.new(url).send(:interpret)
    end

  private

    def initialize(url)
      @url = URI.parse(url.to_s)
      @commands = []
    end

    def interpret
      instance_eval(open(@url.to_s).read)
      @commands
    end

    def method_missing(sym, *args)
      add_command(sym, args.shift, args.shift.to_h)
    end

    def include(path_or_url)
      url = include_url(path_or_url)
      @commands += Dsl.interpret(url)
    end

    def include_url(url)
      url = URI.parse(url)
      if url.absolute?
        url
      else
        dirname = File.dirname(@url.path)
        path = "#{dirname}/#{url.to_s}"
        include_url = @url.clone
        include_url.path = path
        include_url
      end
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

