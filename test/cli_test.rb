require 'teststrap'
require 'robot_sweatshop/tears'

context 'the CLI tool' do
  context 'with no arguments' do
    setup { `#{__dir__}/../bin/sweatshop-tears` }
    denies('will run') { topic.empty? }
  end
end
