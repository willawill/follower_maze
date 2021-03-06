#!/bin/ruby

require "./lib/follower_maze"
options = {}

OptionParser.new do |opts|
  opts.on("--log_level=LogLevel", "change the level of log") { |arg| options[:log_level] = arg }
  opts.on('--event_host=EVENTHOST', 'the host address for event listener') { |arg| options[:event_host] = arg }
  opts.on('--event_port=EVENTPORT', 'the port for event listener') { |arg| options[:event_port] = arg }
  opts.on('--client_host=CLIENTHOST', 'the host for event host address') { |arg| options[:client_host] = arg }
  opts.on('--client_port=CLIENTPORT', 'the host for event host address') { |arg| options[:client_port] = arg }
  opts.on('-h', '--help', 'Display this screen') { puts opts; exit }
end.parse!

event_host = options[:event_host] || "127.0.0.1"
event_port = options[:event_host] || 9099
client_host = options[:client_host] || "127.0.0.1"
client_port = options[:client_port] || 9090
log_level = options[:log_level] || "warn"

$logger.level = Logger.const_get("#{log_level.upcase}")

ServerConfig = Struct.new(:host, :port)

client_config = ServerConfig.new(event_host, event_port)
event_config = ServerConfig.new(client_host, client_port)

server = FollowerMaze::Server.new(client_config, event_config)
server.start