require "rubygems"
require "active_record"
require "yaml"
require "logger"

module Lib
  LOGGER = Logger.new(File.open("../log/shell.log", "a"), "daily")

  module_function

  def debug(msg)
    LOGGER.debug(msg)
  end

  def connect(env="development")
    config = YAML.load_file("../config/database.yml")[env]
    ActiveRecord::Base.establish_connection(config)
  end
end