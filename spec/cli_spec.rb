require 'fileutils'

RSpec.describe 'sweatshop-tears' do
  let(:script_path) { File.expand_path "#{__dir__}/../bin/sweatshop-tears" }
  let(:package_path) { File.expand_path '.test_download_path' }
  context 'with no command' do
    subject { `#{script_path}` }
    it { is_expected.to_not be_empty }
  end
  context 'init' do
    subject { `#{script_path} init --path #{package_path}` }
    after { FileUtils.rm_rf '.test' }
    it { is_expected.to_not be_empty }
    it { expect(Dir).to exist(package_path) }
  end
end
