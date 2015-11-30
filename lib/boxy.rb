require 'boxy/version'
require 'boxy/dsl'
require 'bundler'

module Boxy
  def self.load_commands(url)
    Boxy::Dsl.new.interpret(url)
  end

  def self.install(commands)
    commands.each do |command|
      handler = @@handlers[command.type].new
      Bundler.with_clean_env do
        handler.install(command.name, command.options)
      end
    end
  end

  def self.register(type, command)
    @@handlers ||= {}
    @@handlers[type] = command
  end
end

require 'boxy/pkg'

