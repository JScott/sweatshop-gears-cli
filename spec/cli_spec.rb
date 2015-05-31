require 'fileutils'

SCRIPT_PATH = File.expand_path "#{__dir__}/../bin/sweatshop-tears"
PACKAGE_PATH = File.expand_path '.test_download_path'

RSpec.describe 'sweatshop-tears' do
  context 'with no command' do
    subject { `#{SCRIPT_PATH}` }
    it { is_expected.to_not be_empty }
  end
  context 'init' do
    subject { a = `#{SCRIPT_PATH} init --path #{PACKAGE_PATH}`; p Dir[PACKAGE_PATH]; a }
    after(:all) { FileUtils.rm_rf PACKAGE_PATH; p Dir[PACKAGE_PATH] }
    it { is_expected.to_not be_empty }
    it { expect(Dir).to exist(PACKAGE_PATH) }
  end
end
