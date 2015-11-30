module Boxy
  class PkgHandler
    def install(name, options)
      unless formula_installed?(name)
        system "brew install #{name}"
      else
        puts "skipping #{name}, already installed"
      end
    end

    private

    def formula_installed?(name)
      `brew info #{name} > /dev/null 2>&1`
      $? == 0
    end
  end

  Boxy.register(:pkg, PkgHandler)
end
