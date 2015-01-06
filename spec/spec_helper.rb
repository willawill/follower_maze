require_relative "../lib/follower_maze"

RSpec.configure do |config|
  config.order = :random
  config.color = true
  config.default_formatter = :documentation
  Kernel.srand config.seed
end
