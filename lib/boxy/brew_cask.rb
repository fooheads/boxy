module Boxy
  class BrewCaskHandler
    @@casks ||= `brew cask list`.split
    # puts "Casks: #{@@casks.inspect}"

    def install(name, options)
      unless formula_installed?(name)
        system "brew cask install #{name}"
      else
        puts "skipping #{name}, already installed"
      end
    end

    private

    def formula_installed?(name)
      @@casks.include?(name)
    end
  end

  Boxy.register(:cask, BrewCaskHandler.new)
end

