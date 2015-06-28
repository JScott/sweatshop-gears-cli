require_relative 'teststrap'
require 'http'

context 'sweatshop-gears-hub' do
  setup do
    clean_up_paths
    `sweatshop-gears install reporter --path #{PACKAGES_PATH}`
    `eye start reporter`
    sleep 1
  end
  asserts('it is running') { `eye info | grep --extended-regexp 'service_hub'`.lines.count == 1 }
  # asserts('services load into the port range') { ??? }
  context 'frontpage HTML' do
    setup { HTTP.get('http://localhost:34871').to_s }
    denies_topic.empty
    asserts_topic.matches { /href="\/reporter"/ }
  end
  context 'a service route' do
    setup { HTTP.get('http://localhost:34871/reporter').to_s }
    denies_topic.empty
  end
end
