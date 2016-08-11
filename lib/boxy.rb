require 'boxy/version'
require 'boxy/dsl'
require 'highline'

module Boxy
  def self.load_commands(url)
    Boxy::Dsl.interpret(url).uniq
  end

  def self.validate(commands)
    commands.map do |command|
      command.valid = !!@@handlers[command.type]
      command
    end
  end


  def self.install(commands)
    ensure_xcode_installed

    commands.each do |command|
      handler = @@handlers[command.type]
      with_clean_env do
        handler.install(command.name, command.options)
      end
    end
  end

  def self.register(type, handler)
    @@handlers ||= {}
    @@handlers[type] = handler
  end

  private

  def self.ensure_xcode_installed
    system 'xcode-select -p'
    installed = $?.exitstatus
    if not installed
      cli = HighLine.new
      do_install = cli.agree 'Xcode is not installed, would you like to install it now? (y/n):'
      if do_install
        system 'xcode-select --install'
	cli.ask 'Press enter to continue'
      else
        exit -1
      end
    end
  end

  def self.with_clean_env(&block)
    begin
      require 'bundler'
      Bundler.with_clean_env(&block)
    rescue
      yield
    end
  end

end

require 'boxy/brew'
require 'boxy/brew_cask'
require 'boxy/defaulty'
require 'boxy/homesick'
require 'boxy/luarock'
require 'boxy/mkdirs'

