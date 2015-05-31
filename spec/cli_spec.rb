require 'fileutils'

RSpec.describe 'sweatshop-tears' do
  let(:script_path) { File.expand_path "#{__dir__}/../bin/sweatshop-tears" }
  let(:package_path) { File.expand_path '.test_packages' }
  context 'with no command' do
    subject { `#{script_path}` }
    it { is_expected.to_not be_empty }
  end
  context 'init' do
    subject { p `#{script_path} init --path #{package_path}` }
    after { FileUtils.rm_rf '.test' }
    it { is_expected.to_not be_empty }
    # it { expect(Dir).to exist('.test') }
    it 'should download the scripts' do
      expect(Dir.exist? package_path).to be_truthy
    end
  end
end
