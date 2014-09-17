require_relative "../lib/blackjack.rb"

RSpec.configure do |config|
# config here
end

# method for testing the gets method
def with_stdin
  stdin = $stdin
  $stdin, write = IO.pipe
  yield write
ensure
  write.close
  $stdin = stdin
end