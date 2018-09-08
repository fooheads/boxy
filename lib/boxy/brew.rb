module Boxy
  class BrewPackageHandler
    @@brews ||= `brew list`.split
    # puts "Brews: #{@@brews.inspect}"

    def install(name, options)
      unless formula_installed?(name)
        system "brew install #{name}"
      else
        puts "skipping #{name}, already installed"
      end
    end

    private

    def formula_installed?(name)
      @@brews.include?(name)
    end
  end

  Boxy.register(:brew, BrewPackageHandler.new)
end
