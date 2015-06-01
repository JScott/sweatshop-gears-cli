require 'teststrap'
require 'robot_sweatshop/config'

TEARS_BIN = File.expand_path "#{__dir__}/../bin/sweatshop-tears"
PACKAGES_PATH = File.expand_path '.test_download_path'
SWEATSHOP_SCRIPTS_PATH = File.expand_path configatron.scripts_path

context 'sweatshop-tears' do
  setup { File.expand_path "#{__dir__}/../bin/sweatshop-tears" }
  context '' do
    setup { `#{TEARS_BIN}` }
    denies_topic('the output').empty
  end
  context 'init' do
    setup { `#{TEARS_BIN} init --path #{PACKAGES_PATH}` }
    denies_topic('the output').empty
    asserts('the packages repository is cloned') { File.exist? "#{PACKAGES_PATH}/README.md" }
    asserts('the binaries are available to Sweatshop workers') { File.exist? "#{SWEATSHOP_SCRIPTS_PATH}/git-sync" }
    # asserts('sets up potential services in Eye') {}
    teardown { FileUtils.rm_rf PACKAGES_PATH }
  end
end

# list
# show
# update
