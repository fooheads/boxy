require 'boxy/version'
require 'boxy/dsl'

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
    commands.each do |command|
      handler = @@handlers[command.type]
      Bundler.with_clean_env do
        handler.install(command.name, command.options)
      end
    end
  end

  def self.register(type, handler)
    @@handlers ||= {}
    @@handlers[type] = handler
  end

  def with_clean_env(&block)
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

