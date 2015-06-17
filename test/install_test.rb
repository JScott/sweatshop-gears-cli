require_relative 'teststrap'

context 'sweatshop-gears install' do
  context 'binary' do
    setup { `bin/sweatshop-gears install git-sync --path #{PACKAGES_PATH}` }
    denies_topic('the output').empty
    asserts('packages is downloaded') { File.exist? "#{SWEATSHOP_SCRIPTS_PATH}/git-sync" }
    # asserts('dependencies are installed') { ??? }
  end
  context 'service' do
    setup { `bin/sweatshop-gears install big-green-button --path #{PACKAGES_PATH}` }
    asserts('loads services into Eye') { `eye info | grep big-green-button`.include? 'up' }
  end
  teardown { clean_up_paths }
end
