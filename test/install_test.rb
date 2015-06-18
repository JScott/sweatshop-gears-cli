require_relative 'teststrap'

context 'sweatshop-gears install' do
  setup do
    clean_up_paths
    %w(git-sync big-green-button reporter).each do |package|
      `sweatshop-gears install #{package} --path #{PACKAGES_PATH}`
    end
  end
  denies_topic('the output').empty
  asserts('packages are downloaded') { File.exist? "#{PACKAGES_PATH}/git-sync" }
  asserts('binaries are symlinked') { File.exist? "#{SWEATSHOP_SCRIPTS_PATH}/git-sync" }
  denies('services are symlinked') { File.exist? "#{SWEATSHOP_SCRIPTS_PATH}/big-green-button" }
  asserts('all services are loaded into Eye') { `eye info | grep --extended-regexp 'big-green-button|reporter'`.lines.count == 2 }
  # asserts('dependencies are installed') { ??? }
end
