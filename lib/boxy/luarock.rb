module Boxy
  class LuarockHandler
    def install(name, options)
      unless luarock_installed?(name)
        system "luarocks install #{name}"
      else
        puts "skipping #{name}, already installed"
      end
    end

    private

    def luarock_installed?(name)
      `luarocks show #{name} > /dev/null 2>&1`
      $? == 0
    end
  end

  Boxy.register(:luarock, LuarockHandler)
end



