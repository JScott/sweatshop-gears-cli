require 'terminal-announce'

# Provides information and downloading of Gears packages
module Gears
  module Packages
    def self.clone(git_repo, to_path:)
      Git.clone git_repo, File.basename(to_path), path: File.dirname(to_path)
    end

    def self.packages(gears_path)
      paths = Dir["#{gears_path}/*"].select { |path| File.directory? path }
      paths.map { |path| File.expand_path path }
    end

    def self.data_for(package_name, path)
      install_path = "#{path}/packages/#{package_name}"
      metadata_path = "#{path}/#{package_name}.yaml"
      fail "Metadata for '#{package_name}' not found" unless File.exist? metadata_path
      [install_path, YAML.load_file(metadata_path)]
    end

    def self.install(package_name, from_path:)
      install_path, metadata = data_for package_name, from_path
      clone metadata['repo'], to_path: install_path
      Announce.success "#{package_name} downloaded"
      Gears::Dependencies.install from_path: install_path
      Gears::Binaries.expose from_path: install_path if metadata['type'] == 'binary'
      Gears::Services.load from_path: install_path if metadata['type'] == 'service'
    rescue
      Announce.failure 'Error occurred, rolling back installation'
      FileUtils.rm_rf "#{from_path}/packages/#{package_name}"
    end
  end
end
