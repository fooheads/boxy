module Boxy
  class HomesickHandler
    def install(url, options)
      url = URI.parse(url)
      name = File.basename(url.path)
      unless castle_cloned?(name)
        system "homesick clone #{url.to_s}"
        system "homesick symlink #{name}"
      else
        puts "skipping #{name}, already installed"
      end
    end

    private

    def castle_cloned?(name)
      `homesick status #{name} > /dev/null 2>&1`
      $? == 0
    end
  end

  Boxy.register(:homesick, HomesickHandler.new)
end


