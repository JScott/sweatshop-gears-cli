require_relative 'teststrap'

context 'sweatshop-gears install' do
  setup { clean_up_paths }
  context 'binary' do
    setup { `sweatshop-gears install git-sync --path #{PACKAGES_PATH}` }
    denies_topic('the output').empty
    asserts('packages are downloaded') { File.exist? "#{PACKAGES_PATH}/packages/git-sync" }
    asserts('packages binary is linked') { File.exist? "#{SWEATSHOP_SCRIPTS_PATH}/git-sync" }
    # asserts('dependencies are installed') { ??? }
  end
  context 'service' do
    setup { `sweatshop-gears install big-green-button --path #{PACKAGES_PATH}` }
    denies_topic('the output').empty
    asserts('packages are downloaded') { File.exist? "#{PACKAGES_PATH}/packages/big-green-button" }
    asserts('loads services into Eye') { not `eye info | grep big-green-button`.empty? }
    # asserts('dependencies are installed') { ??? }
  end
end
