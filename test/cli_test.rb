require 'teststrap'
require 'robot_sweatshop/tears'

context 'the CLI tool' do
  setup { File.expand_path "#{__dir__}/../bin/sweatshop-tears" }
  context 'with no arguments' do
    setup { `#{topic}` }
    asserts('doing something') { not topic.empty? }
  end
  context 'with init' do
    setup { `#{topic} init` }
    asserts('doing something') { not topic.empty? }
  end
end

# init
# remove
# list
# show
