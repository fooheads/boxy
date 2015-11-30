require 'defaulty'

module Boxy
  class DefaultyHandler
    def install(domain, options)
      @defaulty ||= Defaulty.load('https://api.github.com/repos/fooheads/osxdefaults/contents/')
      @defaulty.write(domain, options)
    end
  end

  Boxy.register(:osx, DefaultyHandler.new)
end



