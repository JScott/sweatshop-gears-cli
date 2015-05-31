require 'teststrap'

SCRIPT_PATH = File.expand_path "#{__dir__}/../bin/sweatshop-tears"
PACKAGE_PATH = File.expand_path '.test_download_path'

context 'sweatshop-tears' do
  setup { File.expand_path "#{__dir__}/../bin/sweatshop-tears" }
  context '' do
    setup { `#{SCRIPT_PATH}` }
    denies_topic('the output').empty
  end
  context 'init' do
    setup { `#{SCRIPT_PATH} init --path #{PACKAGE_PATH}` }
    denies_topic('the output').empty
    asserts('packages are downloaded') { Dir.exist? PACKAGE_PATH }
    teardown { FileUtils.rm_rf PACKAGE_PATH }
  end
end

# remove
# list
# show
