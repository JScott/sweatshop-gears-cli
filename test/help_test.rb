require_relative 'teststrap'

context 'sweatshop-gears help' do
  setup { `bin/sweatshop-gears help` }
  denies_topic('the output').empty
  teardown { clean_up_paths }
end
