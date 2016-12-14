module Boxy
  class BrewTapHandler
    def install(name, options)
      system "brew tap #{name}"
    end
  end

  Boxy.register(:brew_tap, BrewTapHandler.new)
end

