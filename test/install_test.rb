require_relative 'teststrap'

context 'sweatshop-gears install' do
  setup do
    clean_up_paths
    %w(git-sync big-green-button).each do |package|
      `sweatshop-gears install #{package} --path #{PACKAGES_PATH}`
    end
  end
  denies_topic('the output').empty
  asserts('packages are downloaded') { File.exist? "#{PACKAGES_PATH}/packages/git-sync" }
  asserts('binaries are symlinked') { File.exist? "#{SWEATSHOP_SCRIPTS_PATH}/git-sync" }
  denies('services are symlinked') { File.exist? "#{SWEATSHOP_SCRIPTS_PATH}/big-green-button" }
  asserts('services are loaded into Eye') { not `eye info | grep big-green-button`.empty? }
  # asserts('dependencies are installed') { ??? }
end
