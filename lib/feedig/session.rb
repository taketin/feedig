require 'ostruct'
require 'net/irc'
require 'feedzirra'
require 'yaml'

class Feedig::Session < Net::IRC::Server::Session

  def server_version
    Feedig::VERSION
  end

  def channels
    ['#notification']
  end

  def initialize(*args)
    super
  end

  def client
    @client ||= YAML.load_file('./lib/feedig/resources.yml').inject({}) { |hash, (name, url)|
                  hash[name] = Feedzirra::Feed.fetch_and_parse url
                  hash
                }
  end

  def on_disconnected
    @retrieve_thread.kill rescue nil
  end

  def on_user(m)
    super

    channels.each { |channel| post @nick, JOIN, channel }

    # go to method
    client.each_pair do |name, feed|
      post(
        "RECENT",
        PRIVMSG,
        "#notification",
        "\0035#{name}:\017 \00314#{feed.entries[0].title} [ #{feed.entries[0].url} ] #{feed.entries[0].last_modified}\017"
      )
    end

    @retrieve_thread = Thread.start do
      loop do
        retrieve @opts.interval
      end
    end
  end

  private

  def retrieve(interval)
    @log.info 'retrieveing feed...'

    @client.each_pair do |name, feed|
      if feed.has_new_entries?
        feed.new_entries.each do |new_entry|
          post(
            "NEW",
            PRIVMSG,
            "#notification",
            "\0035#{name}:\017 \00314#{new_entry.title} [ #{new_entry.url} ] #{new_entry.last_modified}\017"
          )
        end
        feed.new_entries = []
      end
    end

    @log.info 'sleep'
    sleep interval
  rescue Exception => e
    @log.error e.inspect
    e.backtrace.each do |l|
      @log.error "\t#{l}"
    end
    sleep 10
  end

end
