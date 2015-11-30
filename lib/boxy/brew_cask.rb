module Boxy
  class BrewCaskHandler
    def install(name, options)
      unless formula_installed?(name)
        system "brew cask install #{name}"
      else
        puts "skipping #{name}, already installed"
      end
    end

    private

    def formula_installed?(name)
      `brew cask list #{name} > /dev/null 2>&1`
      $? == 0
    end
  end

  Boxy.register(:cask, BrewCaskHandler.new)
end

