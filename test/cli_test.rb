require 'teststrap'
require 'robot_sweatshop/tears'

context 'the CLI tool' do
  context 'with no arguments' do
    setup { `#{__dir__}/../bin/sweatshop-tears` }
    asserts('doing something') { not topic.empty? }
  end
end
