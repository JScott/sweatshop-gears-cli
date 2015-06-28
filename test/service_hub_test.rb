require_relative 'teststrap'
require 'http'

context 'sweatshop-gears-hub' do
  setup do
    clean_up_paths
    `sweatshop-gears install reporter --path #{PACKAGES_PATH}`
    `eye start reporter`
  end
  asserts('the Hub is running') { `eye info | grep --extended-regexp 'service_hub'`.lines.count == 1 }
  # asserts('services load into the port range') { ??? }
  context 'the frontpage' do
    setup { HTTP.get('http://localhost:34871').to_s }
    denies_topic.empty
    # asserts('running services are linked to') {  }
  end
end
