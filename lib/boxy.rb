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
    ensure_homebrew_installed

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


  def self.ensure_homebrew_installed
    installed = system 'which brew'
    if not installed
      cli = HighLine.new
      do_install = cli.agree 'Homebrew is not installed, would you like to install it now? (y/n):'
      if do_install
        system '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
      else
        exit -1
      end
    end
  end

  def self.with_clean_env(&block)
    begin
      require 'bundler'
      Bundler.with_clean_env(&block)
    rescue LoadError
      yield
    end
  end

end

require 'boxy/brew'
require 'boxy/brew_cask'
require 'boxy/brew_tap'
require 'boxy/defaulty'
require 'boxy/homesick'
require 'boxy/luarock'
require 'boxy/mkdirs'

