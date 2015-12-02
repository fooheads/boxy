require 'defaulty'

module Boxy
  class DefaultyHandler
    def install(domain, options)
      defaulty_url = ENV['DEFAULTY_URL'] || 'https://api.github.com/repos/fooheads/osxdefaults/contents/'
      @defaulty ||= Defaulty.load(defaulty_url)
      @defaulty.write(domain, options)
    end
  end

  Boxy.register(:osx, DefaultyHandler.new)
end



