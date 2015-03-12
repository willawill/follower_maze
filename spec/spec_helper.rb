ENV["RB_ENV"] = "test"
require_relative "../lib/follower_maze"

class FakeLogger
	def debug(val); end
	def info(val); end
	def fatal(val); end
	def warn(val); end
end

$logger = FakeLogger.new

RSpec.configure do |config|
  config.order = :random
  config.color = true
  config.default_formatter = :documentation
  Kernel.srand config.seed
end
