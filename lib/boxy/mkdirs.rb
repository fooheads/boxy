require 'mkdirs'

module Boxy
  class MkdirsHandler
    def install(dirs_file, options)
      config_file = ARGV[1]
      config_dir = File.dirname(config_file)
      root_dir = options[:root_dir] || ENV['HOME']

      puts "mkdirs #{dirs_file} #{root_dir}"
      Mkdirs.apply_filename(File.join(config_dir, dirs_file), root_dir)
    end
  end

  Boxy.register(:mkdirs, MkdirsHandler.new)
end
