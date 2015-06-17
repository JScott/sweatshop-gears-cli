require_relative 'teststrap'

context 'sweatshop-gears help' do
  teardown { clean_up_paths }
  setup { `bin/sweatshop-gears help` }
  denies_topic('the output').empty
end
