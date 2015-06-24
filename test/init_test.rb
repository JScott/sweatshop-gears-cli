require_relative 'teststrap'
require 'fileutils'


context 'sweatshop-gears init' do
  teardown { clean_up_paths }
  setup { `bin/sweatshop-gears init --path #{PACKAGES_PATH}` }
  denies_topic('the output').empty
  asserts('metadata is downloaded') { File.exist? "#{PACKAGES_PATH}/git-sync.yaml" }
  denies('packages are downloaded') { File.exist? "#{SWEATSHOP_SCRIPTS_PATH}/scripts/git-sync" }
end
