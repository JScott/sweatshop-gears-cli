require 'teststrap'
require 'robot_sweatshop/config'

# TODO: would serverspec be more appropriate for testing CLI tools?

GEARS_BIN = File.expand_path "#{__dir__}/../bin/sweatshop-gears"
PACKAGES_PATH = File.expand_path '.test_download_path'
SWEATSHOP_SCRIPTS_PATH = File.expand_path configatron.scripts_path

context 'sweatshop-gears' do
  setup { File.expand_path "#{__dir__}/../bin/sweatshop-gears" }
  context '' do
    setup { `#{GEARS_BIN}` }
    denies_topic('the output').empty
  end
  context 'init' do
    setup { `#{GEARS_BIN} init --path #{PACKAGES_PATH}` }
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
