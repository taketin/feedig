require 'net/irc'
require 'logger'

module Feedig::Client
  def self.run
    opts = Feedig::OptParser.parse!(ARGV)

    opts[:logger] = Logger.new(opts[:log], "daily")
    opts[:logger].level = opts[:debug] ? Logger::DEBUG : Logger::INFO

    Net::IRC::Server.new(opts[:host], opts[:port], Feedig::Session, opts).start
  end
end
